import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({Key? key}) : super(key: key);

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  double? _direction;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getLocation();
    FlutterCompass.events?.listen((event) {
      setState(() {
        _direction = event.heading;
      });
    });
  }

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return;
      }
    }

    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
  }

  double _calculateQiblaDirection(double lat, double lon) {
    const double kaabaLat = 21.4225;
    const double kaabaLon = 39.8262;

    final double latRad = lat * pi / 180;
    final double lonRad = lon * pi / 180;
    final double kaabaLatRad = kaabaLat * pi / 180;
    final double kaabaLonRad = kaabaLon * pi / 180;

    final double deltaLon = kaabaLonRad - lonRad;
    final double x = sin(deltaLon);
    final double y = cos(latRad) * tan(kaabaLatRad) - sin(latRad) * cos(deltaLon);

    final double bearing = atan2(x, y);
    return (bearing * 180 / pi + 360) % 360;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (_currentPosition == null || _direction == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final qiblaDirection = _calculateQiblaDirection(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    );

    final difference = qiblaDirection - _direction!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Qibla Direction",
          style: GoogleFonts.nunito(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/compass.png',
              width: size.width * 0.7,
              height: size.width * 0.7,
            ),
            Transform.rotate(
              angle: difference * (pi / 180),
              child: Image.asset(
                'assets/images/qibla-arrow.png',
                width: size.width * 0.4,
                height: size.width * 0.4,
              ),
            ),
            Positioned(
              bottom: 50,
              child: Column(
                children: [
                  Text(
                    'Qibla is at ${qiblaDirection.toStringAsFixed(2)}°',
                    style: GoogleFonts.nunito(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Your heading: ${_direction!.toStringAsFixed(2)}°',
                    style: GoogleFonts.nunito(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

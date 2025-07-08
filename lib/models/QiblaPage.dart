// import 'dart:async';
// import 'dart:math' show pi;

// import 'package:flutter/material.dart';
// import 'package:flutter_qiblah/flutter_qiblah.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';

// class QiblaPage extends StatefulWidget {
//   const QiblaPage({super.key});

//   @override
//   State<QiblaPage> createState() => _QiblaPageState();
// }

// class _QiblaPageState extends State<QiblaPage> {
//   bool _locationPermissionGranted = false;
//   Stream<QiblahDirection>? _qiblahStream;
//   late GoogleMapController _mapController;
//   Position? _currentPosition;

//   final LatLng kaabaLatLng = const LatLng(21.4225, 39.8262);

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissions();
//   }

//   Future<void> _checkPermissions() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       final position = await Geolocator.getCurrentPosition();
//       setState(() {
//         _locationPermissionGranted = true;
//         _currentPosition = position;
//         _qiblahStream = FlutterQiblah.qiblahStream;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("🧭 Qibla Direction")),
//       body: !_locationPermissionGranted
//           ? const Center(child: Text("Location permission is required."))
//           : _currentPosition == null
//               ? const Center(child: CircularProgressIndicator())
//               : Column(
//                   children: [
//                     // Compass Section
//                     Expanded(
//                       flex: 1,
//                       child: StreamBuilder<QiblahDirection>(
//                         stream: _qiblahStream,
//                         builder: (_, snapshot) {
//                           if (!snapshot.hasData) {
//                             return const Center(child: CircularProgressIndicator());
//                           }

//                           final direction = snapshot.data!.qiblah;

//                           return Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Image.asset('assets/images/compass.png', width: 200),
//                               Transform.rotate(
//                                 angle: (direction) * (pi / 180),
//                                 child:
//                                     Image.asset('assets/images/needle.png', width: 150),
//                               ),
//                               const Positioned(
//                                 bottom: 10,
//                                 child: Text("Align the needle to find Qibla",
//                                     style: TextStyle(fontSize: 14)),
//                               )
//                             ],
//                           );
//                         },
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     // Google Map Section
//                     Expanded(
//                       flex: 1,
//                       child: GoogleMap(
//                         onMapCreated: (controller) => _mapController = controller,
//                         initialCameraPosition: CameraPosition(
//                           target: LatLng(_currentPosition!.latitude,
//                               _currentPosition!.longitude),
//                           zoom: 14,
//                         ),
//                         markers: {
//                           Marker(
//                               markerId: const MarkerId('user'),
//                               position: LatLng(_currentPosition!.latitude,
//                                   _currentPosition!.longitude),
//                               infoWindow: const InfoWindow(title: "You")),
//                           Marker(
//                               markerId: const MarkerId('kaaba'),
//                               position: kaabaLatLng,
//                               icon: BitmapDescriptor.defaultMarkerWithHue(
//                                   BitmapDescriptor.hueOrange),
//                               infoWindow: const InfoWindow(title: "Kaaba")),
//                         },
//                         polylines: {
//                           Polyline(
//                             polylineId: const PolylineId('qibla_line'),
//                             color: Colors.teal,
//                             width: 3,
//                             points: [
//                               LatLng(_currentPosition!.latitude,
//                                   _currentPosition!.longitude),
//                               kaabaLatLng,
//                             ],
//                           )
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//     );
//   }
// }

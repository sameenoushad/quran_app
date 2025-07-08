import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

class PrayerTimePage extends StatefulWidget {
  const PrayerTimePage({super.key});

  @override
  State<PrayerTimePage> createState() => _PrayerTimePageState();
}

class _PrayerTimePageState extends State<PrayerTimePage> {
  late Timer _timer;
  String _currentTime = '';
  final player = AudioPlayer();
  final playedFlags = <String>{};
  bool _isAlarmEnabled = true; // 🔔 Toggle for alarm

  final List<Map<String, String>> prayerTimes = const [
    {"name": "الفجر (Fajr)", "time": "04:45 AM"},
    {"name": "الظهر (Dhuhr)", "time": "12:30 PM"},
    {"name": "العصر (Asr)", "time": "04:15 PM"},
    {"name": "المغرب (Maghrib)", "time": "07:00 PM"},
    {"name": "العشاء (Isha)", "time": "08:30 PM"},
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
      _checkPrayerTimes();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('hh:mm:ss a').format(now);
    });
  }

  void _checkPrayerTimes() {
    final now = DateFormat('hh:mm a').format(DateTime.now());

    for (var prayer in prayerTimes) {
      final time = prayer['time']!;
      if (now == time && !playedFlags.contains(time)) {
        if (_isAlarmEnabled) {
          _playAlarm();
        }
        playedFlags.add(time);
      }
    }
  }

  Future<void> _playAlarm() async {
    await player.play(AssetSource('assets/audios/azan1.mp3'));
  }

  @override
  void dispose() {
    _timer.cancel();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade800,
        title: Text(
          'مواقيت الصلاة',
          style: GoogleFonts.amiri(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Switch(
            value: _isAlarmEnabled,
            onChanged: (value) {
              setState(() {
                _isAlarmEnabled = value;
              });
            },
            activeColor: Colors.white,
            inactiveThumbColor: Colors.grey.shade300,
            inactiveTrackColor: Colors.grey.shade400,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'المنطقة الحالية: كراتشي، باكستان',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.teal.shade800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'الوقت الحالي: $_currentTime',
              style: GoogleFonts.amiri(
                fontSize: 20,
                color: Colors.teal.shade900,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: prayerTimes.length,
                itemBuilder: (context, index) {
                  final prayer = prayerTimes[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.shade100,
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prayer['name']!,
                            style: GoogleFonts.amiri(
                              fontSize: 22,
                              color: Colors.teal.shade900,
                            ),
                          ),
                          Text(
                            prayer['time']!,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.teal.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

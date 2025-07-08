import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/models/HadithPage.dart';
import 'package:flutter_application_1/models/PrayerTimePage.dart';
import 'package:flutter_application_1/models/QiblaPage.dart';
import 'package:flutter_application_1/models/TasbeehPage.dart';
import 'package:flutter_application_1/models/asmaulhusna.dart';
import 'package:flutter_application_1/models/prophetname.dart';
import 'package:flutter_application_1/models/quran.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'DetailSurahScreen.dart';

class Surah {
  final int number;
  final String nameArabic;
  final String nameTranslit;
  final String nameEnglish;
  final String revelationType;

  Surah({
    required this.number,
    required this.nameArabic,
    required this.nameTranslit,
    required this.nameEnglish,
    required this.revelationType,
  });

  factory Surah.fromJson(Map<String, dynamic> j) => Surah(
        number: j['number'],
        nameArabic: j['name'],
        nameTranslit: j['englishName'],
        nameEnglish: j['englishNameTranslation'] ?? '',
        revelationType: j['revelationType'],
      );
}

class SurahIndexScreen extends StatefulWidget {
  const SurahIndexScreen({super.key});

  @override
  State<SurahIndexScreen> createState() => _SurahIndexScreenState();
}

class _SurahIndexScreenState extends State<SurahIndexScreen> {
  late VideoPlayerController _videoController;

  List<Surah> _all = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(
        'https://v1.pinimg.com/videos/mc/720p/0e/49/10/0e4910371644339582c8c91ca4d345bd.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
        setState(() {});
      });

    _fetchSurahs();
  }

  Future<void> _fetchSurahs() async {
    const url = 'https://api.alquran.cloud/v1/surah';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['data'] as List;
        _all = data.map((e) => Surah.fromJson(e)).toList();
      } else {
        _error = 'Server responded with ${res.statusCode}';
      }
    } catch (e) {
      _error = 'Network error: $e';
    }
    if (mounted) setState(() => _loading = false);
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget _buildCarouselItem({
    required IconData icon,
    required String label,
    required Widget targetPage,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade200,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal.shade100,
            child: IconButton(
              icon: Icon(icon, color: Colors.teal.shade800, size: 28),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => targetPage),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : Column(
                  children: [
                    /// Video Banner
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          if (_videoController.value.isInitialized)
                            FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoController.value.size.width,
                                height: _videoController.value.size.height,
                                child: VideoPlayer(_videoController),
                              ),
                            )
                          else
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    ),

                    /// Carousel Menu
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 100,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        viewportFraction: 0.4,
                      ),
                      items: [
                        // _buildCarouselItem(icon: Icons.explore, label: 'Qibla', targetPage: const QiblaPage()),
                        _buildCarouselItem(icon: Icons.book, label: 'Hadith', targetPage: const HadithPage()),
                        _buildCarouselItem(icon: Icons.schedule, label: 'Prayer Time', targetPage: const PrayerTimePage()),
                        _buildCarouselItem(icon: Icons.brightness_low, label: 'Tasbeeh', targetPage: const TasbeehPage()),
                        _buildCarouselItem(icon: Icons.menu_book, label: 'Quran', targetPage: const Quran()),
                        _buildCarouselItem(icon: Icons.brightness_low, label: 'Asmaulhusna', targetPage:  Asmaulhusna()),
                        _buildCarouselItem(icon: Icons.brightness_low, label: 'Prophets', targetPage: NamesOfProphet()),
                      ],
                    ),

                    /// Surah List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _all.length,
                        itemBuilder: (_, i) {
                          final s = _all[i];
                          return Card(
                            color: Colors.white,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailSurahScreen(surahNum: s.number),
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal.shade700,
                                foregroundColor: Colors.white,
                                child: Text(
                                  '${s.number}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(
                                '${s.nameArabic} | ${s.nameTranslit}',
                                style: GoogleFonts.amiriQuran(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                s.nameEnglish,
                                style: TextStyle(
                                  color: Colors.teal.shade800,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              trailing: Image.asset(
                                s.revelationType == 'Meccan'
                                    ? 'assets/images/kaaba.png'
                                    : 'assets/images/madina.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}

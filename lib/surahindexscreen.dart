import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/customeappbar.dart';
import 'package:flutter_application_1/detailsurahscreen.dart';
import 'package:flutter_application_1/models/HadithPage .dart' show HadithPage;
import 'package:flutter_application_1/models/PrayerTimePage.dart';
import 'package:flutter_application_1/models/QiblaPage.dart';
import 'package:flutter_application_1/models/TasbeehPage.dart';
import 'package:flutter_application_1/models/asmaulhusna.dart';
import 'package:flutter_application_1/models/prophetname.dart';
import 'package:flutter_application_1/models/quran.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:hijri/hijri_calendar.dart';

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
  List<Surah> _all = [];
  List<Surah> _filtered = [];
  bool _loading = true;
  String? _error;

  String _currentTime = '';
  String _islamicDate = '';
  final List<String> _prayers = ["Fajr", "Dhuhr", "Asr", "Maghrib", "Isha"];

  Future<void> _fetchSurahs() async {
    const url = 'https://api.alquran.cloud/v1/surah';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body)['data'] as List;
        _all = data.map((e) => Surah.fromJson(e)).toList();
        _filtered = List.from(_all);
      } else {
        _error = 'Server responded with ${res.statusCode}';
      }
    } catch (e) {
      _error = 'Network error: $e';
    }
    if (mounted) setState(() => _loading = false);
  }

  void _updateTimeAndDate() {
    final now = DateTime.now();
    _currentTime = DateFormat('hh:mm a').format(now);
    final hijri = HijriCalendar.now();
    _islamicDate = '${hijri.hDay} ${hijri.longMonthName} ${hijri.hYear} AH';
    setState(() {});
  }

  void _filterSurahs(String query) {
    final lower = query.toLowerCase();
    setState(() {
      _filtered = _all.where((surah) {
        return surah.nameArabic.contains(lower) ||
            surah.nameTranslit.toLowerCase().contains(lower) ||
            surah.nameEnglish.toLowerCase().contains(lower);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSurahs();
    _updateTimeAndDate();
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA),
      appBar: CustomAppBar(
        title: "Al-Quran",
        onSearchChanged: _filterSurahs,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.tealAccent),))
              : Column(
                  children: [
                  /// 🖼️ Updated Banner with Modern UI
Container(
  width: double.infinity,
  height: 220,
  decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(24),
      bottomRight: Radius.circular(24),
    ),
    image: DecorationImage(
      image: AssetImage('assets/images/banner1.jpg'),
      fit: BoxFit.cover,
    ),
  ),
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.2),
          Colors.black.withOpacity(0.8),
        ],
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.access_time_filled, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _prayers.join("  •  "),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.schedule, color: Colors.white70, size: 16),
            const SizedBox(width: 6),
            Text(
              'Current Time: $_currentTime',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
            const SizedBox(width: 6),
            Text(
              'Islamic Date: $_islamicDate',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ],
    ),
  ),
),


                    /// 🎡 Carousel Menu
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 100,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        viewportFraction: 0.4,
                      ),
                      items: [
                        _buildCarouselItem(icon: Icons.book, label: 'Hadith', targetPage: const HadithPage()),
                        _buildCarouselItem(icon: Icons.schedule, label: 'Prayer Time', targetPage: const PrayerTimePage()),
                        _buildCarouselItem(icon: Icons.brightness_low, label: 'Tasbeeh', targetPage: const TasbeehPage()),
                        _buildCarouselItem(icon: Icons.menu_book, label: 'Quran', targetPage: const Quran()),
                        _buildCarouselItem(icon: Icons.brightness_low, label: 'Asmaulhusna', targetPage: Asmaulhusna()),
                        _buildCarouselItem(icon: Icons.brightness_low, label: 'Prophets', targetPage: NamesOfProphet()),
                      ],
                    ),

                    /// 📖 Surah List
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) {
                          final s = _filtered[i];
                          return Card(
                            color: Colors.white,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => DetailSurahScreen(surahNum: s.number)),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Colors.teal.shade700,
                                foregroundColor: Colors.white,
                                child: Text('${s.number}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              title: Text('${s.nameArabic} | ${s.nameTranslit}',
                                  style: GoogleFonts.amiriQuran(fontSize: 20, fontWeight: FontWeight.bold)),
                              subtitle: Text(s.nameEnglish,
                                  style: TextStyle(color: Colors.teal.shade800, fontWeight: FontWeight.w600)),
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

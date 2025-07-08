import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Quran extends StatefulWidget {
  const Quran({super.key});

  @override
  State<Quran> createState() => _QuranState();
}

class _QuranState extends State<Quran> {
  Map<int, List> juzAyahs = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAllJuz();
  }

  Future<void> fetchAllJuz() async {
    final tempMap = <int, List>{};
    for (int i = 1; i <= 30; i++) {
      final res = await http.get(Uri.parse('https://api.alquran.cloud/v1/juz/$i/quran-uthmani'));
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        tempMap[i] = jsonData['data']['ayahs'];
      } else {
        tempMap[i] = [];
      }
    }
    setState(() {
      juzAyahs = tempMap;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'القرآن الكريم - ٣٠ جزء',
            style: GoogleFonts.amiri(fontSize: 26, color: Colors.white),
          ),
          backgroundColor: Colors.teal.shade800,
          centerTitle: true,
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    final juzNumber = index + 1;
                    final ayahs = juzAyahs[juzNumber] ?? [];

                    // Get the first Surah name in the Juz
                    String paraName = '';
                    if (ayahs.isNotEmpty) {
                      paraName = ayahs.first['surah']['name'] ?? '';
                    }

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      elevation: 6,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        title: Text(
                          'الجزء $juzNumber - $paraName',
                          style: GoogleFonts.amiri(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: Colors.teal.shade900,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: ayahs.map<Widget>((ayah) {
                                final String ayahText = ayah['text'];
                                final int ayahNumber = ayah['numberInSurah'];
                                final String surahName = ayah['surah']['name'] ?? '';

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.teal.shade100.withOpacity(0.3),
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Surah and Ayah number
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'سورة $surahName',
                                              style: GoogleFonts.amiri(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal.shade700,
                                              ),
                                            ),
                                            Text(
                                              'آية $ayahNumber',
                                              style: GoogleFonts.amiri(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.teal.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        // Ayah text
                                        Text(
                                          ayahText,
                                          style: GoogleFonts.amiriQuran(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            height: 2.2,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}

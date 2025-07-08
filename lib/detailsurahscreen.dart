import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:quran/quran.dart' as quran;

class Ayah {
  final int numberInSurah;
  final String arabic;
  final String english;

  Ayah({required this.numberInSurah, required this.arabic, required this.english});
}

class DetailSurahScreen extends StatefulWidget {
  final int surahNum;
  const DetailSurahScreen({super.key, required this.surahNum});

  @override
  State<DetailSurahScreen> createState() => _DetailSurahScreenState();
}

class _DetailSurahScreenState extends State<DetailSurahScreen> {
  late int currentSurah;
  late Future<List<Ayah>> _ayahFuture;

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  IconData playPauseIcon = Icons.play_circle_fill;

  static const _arEdition = 'quran-uthmani';
  static const _enEdition = 'en.asad';

  @override
  void initState() {
    super.initState();
    currentSurah = widget.surahNum;
    _ayahFuture = _fetchAyahs(currentSurah);

    audioPlayer.playerStateStream.listen((state) {
      setState(() {
        isPlaying = state.playing;
        playPauseIcon =
            isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<List<Ayah>> _fetchAyahs(int surah) async {
    final responses = await Future.wait([
      http.get(Uri.parse('https://api.alquran.cloud/v1/surah/$surah/$_arEdition')),
      http.get(Uri.parse('https://api.alquran.cloud/v1/surah/$surah/$_enEdition')),
    ]);

    if (responses.any((r) => r.statusCode != 200)) {
      throw Exception('API Error');
    }

    final arabicAyahs = jsonDecode(responses[0].body)['data']['ayahs'] as List;
    final englishAyahs = jsonDecode(responses[1].body)['data']['ayahs'] as List;

    return List.generate(arabicAyahs.length, (i) {
      return Ayah(
        numberInSurah: arabicAyahs[i]['numberInSurah'],
        arabic: arabicAyahs[i]['text'],
        english: englishAyahs[i]['text'],
      );
    });
  }

  Future<void> toggleAudio() async {
    final url =
        'https://cdn.islamic.network/quran/audio-surah/128/ar.alafasy/$currentSurah.mp3';
    if (!isPlaying) {
      await audioPlayer.setUrl(url);
      await audioPlayer.play();
    } else {
      await audioPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final surahName = quran.getSurahName(currentSurah);
    final arabicName = quran.getSurahNameArabic(currentSurah);
    final totalAyahs = quran.getVerseCount(currentSurah);
    final revelation = quran.getPlaceOfRevelation(currentSurah);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          surahName,
          style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
        actions: [
          IconButton(onPressed: toggleAudio, icon: Icon(playPauseIcon, color: Colors.white)),
        ],
      ),
      body: FutureBuilder<List<Ayah>>(
        future: _ayahFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.teal));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.black87)));
          }

          final ayahs = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      surahName,
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text("The Opening", style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 8),
                    Text(
                      "$revelation · $totalAyahs VERSES",
                      style: const TextStyle(color: Colors.white60),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      arabicName,
                      style: GoogleFonts.amiri(
                        fontSize: 28,
                        color: Colors.white,
                        height: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ...ayahs.map((a) => Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.shade100,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.teal,
                              child: Text('${a.numberInSurah}',
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.teal),
                                  onPressed: () {}, // Add share logic
                                ),
                                IconButton(
                                  icon: const Icon(Icons.play_arrow_rounded, color: Colors.teal),
                                  onPressed: () {}, // Add play logic
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          a.arabic,
                          textAlign: TextAlign.right,
                          style: GoogleFonts.amiri(
                            fontSize: 24,
                            color: Colors.black87,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          a.english,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

// -------------------- HADITH BOOK LIST ---------------------
class HadithPage extends StatefulWidget {
  const HadithPage({super.key});

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  List books = [];

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse(
        "https://hadithapi.com/api/books?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        books = data["books"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text("Hadith Books", style: GoogleFonts.notoSansArabic(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            color: Colors.teal.shade50,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
              ),
              title: Text(book["bookName"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(book["writerName"]),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("📚 ${book["chapters_count"]}", style: const TextStyle(fontSize: 12)),
                  Text("📖 ${book["hadiths_count"]}", style: const TextStyle(fontSize: 12)),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookChaptersPage(bookSlug: book["bookSlug"]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// -------------------- CHAPTERS ---------------------
class BookChaptersPage extends StatefulWidget {
  final String bookSlug;
  const BookChaptersPage({super.key, required this.bookSlug});

  @override
  State<BookChaptersPage> createState() => _BookChaptersPageState();
}

class _BookChaptersPageState extends State<BookChaptersPage> {
  List chapters = [];

  Future<void> fetchChapters() async {
    final response = await http.get(Uri.parse(
        "https://hadithapi.com/api/${widget.bookSlug}/chapters?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        chapters = data["chapters"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text("Chapters", style: GoogleFonts.notoSansArabic(fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return Card(
            color: Colors.teal.shade50,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Text(chapter["chapterNumber"], style: const TextStyle(color: Colors.white)),
              ),
              title: Text(
                chapter["chapterArabic"],
                textAlign: TextAlign.right,
                style: GoogleFonts.amiriQuran(fontSize: 22, color: Colors.teal.shade800),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    chapter["chapterUrdu"],
                    textAlign: TextAlign.right,
                    style: GoogleFonts.notoNastaliqUrdu(fontSize: 14, color: Colors.teal.shade900),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chapter["chapterEnglish"],
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HadithListPage(
                      bookSlug: chapter["bookSlug"],
                      chapterNumber: chapter["chapterNumber"],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// -------------------- HADITH LIST WITH SEARCH ---------------------
class HadithListPage extends StatefulWidget {
  final String bookSlug;
  final String chapterNumber;
  const HadithListPage({
    super.key,
    required this.bookSlug,
    required this.chapterNumber,
  });

  @override
  State<HadithListPage> createState() => _HadithListPageState();
}

class _HadithListPageState extends State<HadithListPage> {
  List hadiths = [];
  List filteredHadiths = [];
  TextEditingController searchController = TextEditingController();

  Future<void> fetchHadiths() async {
    final response = await http.get(Uri.parse(
        "https://hadithapi.com/public/api/hadiths?apiKey=\$2y\$10\$BylaBcXs5Lw7ZOtYmQ3PXO1x15zpp26oc1FeGktdmF6YeYoRd88e&book=${widget.bookSlug}&chapter=${widget.chapterNumber}&paginate=100000"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        hadiths = data["hadiths"]["data"];
        filteredHadiths = hadiths;
      });
    }
  }

  void filterHadiths(String query) {
    final filtered = hadiths.where((hadith) {
      final arabic = hadith["hadithArabic"]?.toString() ?? '';
      final urdu = hadith["hadithUrdu"]?.toString() ?? '';
      final searchLower = query.toLowerCase();
      return arabic.contains(query) || urdu.contains(searchLower);
    }).toList();

    setState(() {
      filteredHadiths = filtered;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchHadiths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
        title: Text("Ahadith", style: GoogleFonts.notoSansArabic(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              controller: searchController,
              onChanged: filterHadiths,
              decoration: InputDecoration(
                hintText: 'Search Hadith in Arabic or Urdu...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.teal.shade50,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal.shade300, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // 📖 Hadith List
          Expanded(
            child: ListView.builder(
              itemCount: filteredHadiths.length,
              itemBuilder: (context, index) {
                final hadith = filteredHadiths[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(hadith["hadithNumber"], style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          hadith["hadithArabic"],
                          textAlign: TextAlign.right,
                          style: GoogleFonts.amiriQuran(fontSize: 22, color: Colors.teal.shade800),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          hadith["hadithUrdu"],
                          textAlign: TextAlign.right,
                          style: GoogleFonts.notoNastaliqUrdu(fontSize: 16, color: Colors.grey.shade900),
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
    );
  }
}

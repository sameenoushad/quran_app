import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class HadithPage extends StatefulWidget {
  const HadithPage({super.key});

  @override
  State<HadithPage> createState() => _HadithPageState();
}

class _HadithPageState extends State<HadithPage> {
  List<String> books = [];
  String? selectedBook;
  String hadithId = '1';
  String lang = 'eng';
  Map<String, dynamic>? hadith;
  late SharedPreferences prefs;
  List<String> favorites = [];

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    await _loadBooks();
    selectedBook = prefs.getString('lastBook') ?? books.first;
    hadithId = prefs.getString('lastHadith') ?? '1';
    lang = prefs.getString('lastLang') ?? 'eng';
    favorites = prefs.getStringList('favorites') ?? [];
    await _loadHadith();
  }

  Future<void> _loadBooks() async {
    final url = Uri.parse('https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions.json');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as Map<String, dynamic>;
      setState(() {
        books = (data['editions'] as Map<String, dynamic>)
            .keys
            .where((k) => k.startsWith(lang))
            .toList();
      });
    }
  }

  Future<void> _loadHadith() async {
    if (selectedBook == null) return;
    final url = Uri.parse(
        'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/$selectedBook/$hadithId.json');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      setState(() => hadith = json.decode(res.body));
      await prefs.setString('lastBook', selectedBook!);
      await prefs.setString('lastHadith', hadithId);
      await prefs.setString('lastLang', lang);
    }
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: hadith?['hadith'] ?? ''));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Copied to clipboard")),
    );
  }

  void _shareText() async {
    final text = hadith?['hadith'] ?? '';
    final url = Uri.parse("mailto:?subject=Hadith&body=$text");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _toggleFavorite() async {
    final key = '$selectedBook:$hadithId';
    setState(() {
      if (favorites.contains(key)) {
        favorites.remove(key);
      } else {
        favorites.add(key);
      }
    });
    await prefs.setStringList('favorites', favorites);
  }

  void _searchHadith() async {
    final query = await showDialog<String>(
      context: context,
      builder: (context) {
        String input = '';
        return AlertDialog(
          title: const Text("Search Hadith"),
          content: TextField(
            decoration: const InputDecoration(hintText: "Enter keyword..."),
            onChanged: (value) => input = value,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(input),
              child: const Text("Search"),
            )
          ],
        );
      },
    );

    if (query != null && query.isNotEmpty) {
      for (int i = 1; i <= 1000; i++) {
        final url = Uri.parse(
            'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions/$selectedBook/$i.json');
        final res = await http.get(url);
        if (res.statusCode == 200) {
          final data = json.decode(res.body);
          if ((data['hadith'] as String).toLowerCase().contains(query.toLowerCase())) {
            setState(() {
              hadithId = i.toString();
              hadith = data;
            });
            return;
          }
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No results found.")),
      );
    }
  }

  bool get isFavorite => favorites.contains('$selectedBook:$hadithId');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hadith Explorer'),
        actions: [
          IconButton(onPressed: _searchHadith, icon: const Icon(Icons.search)),
          DropdownButton<String>(
            value: lang,
            dropdownColor: theme.appBarTheme.backgroundColor,
            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
            underline: const SizedBox(),
            onChanged: (v) async {
              lang = v!;
              await _loadBooks();
              selectedBook = books.first;
              await _loadHadith();
            },
            items: ['eng', 'urd', 'ar']
                .map((l) => DropdownMenuItem(value: l, child: Text(l.toUpperCase())))
                .toList(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (books.isEmpty)
              const Center(child: CircularProgressIndicator())
            else ...[
              DropdownButtonFormField<String>(
                value: selectedBook,
                decoration: const InputDecoration(labelText: 'Select book'),
                items: books
                    .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                    .toList(),
                onChanged: (v) {
                  setState(() {
                    selectedBook = v;
                    hadith = null;
                  });
                  _loadHadith();
                },
              ),
              TextFormField(
                initialValue: hadithId,
                decoration: const InputDecoration(labelText: 'Hadith #'),
                keyboardType: TextInputType.number,
                onFieldSubmitted: (v) {
                  hadithId = v;
                  _loadHadith();
                },
              ),
              const SizedBox(height: 10),
            ],
            if (hadith == null)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hadith!['hadith'] ?? '',
                            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          if (hadith!['reference'] != null)
                            Text('📌 Reference: ${hadith!['reference']}',
                                style: theme.textTheme.bodySmall),
                          if (hadith!['grade'] != null)
                            Text('✅ Grade: ${hadith!['grade']}',
                                style: theme.textTheme.bodySmall),
                          if (hadith!['explanation'] != null) ...[
                            const Divider(height: 30),
                            Text('📝 Explanation:\n${hadith!['explanation']}',
                                style: theme.textTheme.bodyMedium),
                          ],
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(onPressed: _copyText, icon: const Icon(Icons.copy)),
                              IconButton(onPressed: _shareText, icon: const Icon(Icons.share)),
                              IconButton(
                                onPressed: _toggleFavorite,
                                icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

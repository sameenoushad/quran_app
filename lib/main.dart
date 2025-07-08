import 'package:flutter/material.dart';
import 'package:flutter_application_1/Splashscreen.dart';

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mushaf App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Color(0xFFF7F9FA),
        textTheme: GoogleFonts.amiriQuranTextTheme(),
      ),
      home: SplashScreen(),
    );
  }
}


// class SurahIndexScreen extends StatefulWidget {
//   const SurahIndexScreen({super.key});

//   @override
//   State<SurahIndexScreen> createState() => _SurahIndexScreenState();
// }

// class _SurahIndexScreenState extends State<SurahIndexScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "مصحف",
//           style: GoogleFonts.amiri(fontSize: 26, color: Colors.white),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.teal, Colors.green],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         elevation: 4,
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//         itemCount: 114,
//         itemBuilder: (context, index) {
//           return Card(
//             elevation: 2,
//             margin: const EdgeInsets.symmetric(vertical: 6),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ListTile(
//               contentPadding: const EdgeInsets.symmetric(
//                 vertical: 10,
//                 horizontal: 16,
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => detailSurah(index + 1),
//                   ),
//                 );
//               },
//               leading: CircleAvatar(
//                 backgroundColor: Colors.teal.shade100,
//                 child: Text("${index + 1}"),
//               ),
//               title: Text(
//                 "${quran.getSurahNameArabic(index + 1)} | ${quran.getSurahName(index + 1)}",
//                 style: GoogleFonts.amiriQuran(fontSize: 20),
//               ),
//               subtitle: Text(
//                 quran.getSurahNameEnglish(index + 1),
//                 style: TextStyle(color: Colors.grey.shade700),
//               ),
//               trailing: Icon(Icons.arrow_forward_ios_rounded, size: 16),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// class OptionScreen extends StatefulWidget {
//   const OptionScreen({super.key});

//   @override
//   State<OptionScreen> createState() => _OptionScreenState();
// }

// class _OptionScreenState extends State<OptionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(onPressed: () {}, child: Text("Recitation|")),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => OptionScreen()),
//               );
//             },
//             child: Text("Read|"),
//           ),
//         ],
//       ),
//     );
//   }
// }


// class detailSurah extends StatefulWidget {
//   final int SurahNum;

//   const detailSurah(this.SurahNum, {super.key});

//   @override
//   State<detailSurah> createState() => _detailSurahState();
// }

// class _detailSurahState extends State<detailSurah> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           quran.getSurahName(widget.SurahNum),
//           style: GoogleFonts.amiri(color: Colors.white),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.teal, Colors.green],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         elevation: 4,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: ListView.builder(
//             itemCount: quran.getVerseCount(widget.SurahNum),
//             itemBuilder: (context, index) {
//               return Card(
//                 margin: const EdgeInsets.symmetric(vertical: 6),
//                 color: Colors.white,
//                 elevation: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                     horizontal: 14,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         quran.getVerse(
//                           widget.SurahNum,
//                           index + 1,
//                           verseEndSymbol: true,
//                         ),
//                         textAlign: TextAlign.right,
//                         style: GoogleFonts.amiri(fontSize: 22, height: 1.7),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         quran.getVerseTranslation(
//                           widget.SurahNum,
//                           index + 1,
//                           translation: quran.Translation.urdu,
//                         ),
//                         textAlign: TextAlign.right,
//                         textDirection: TextDirection.rtl,
//                         style: TextStyle(
//                           color: Colors.grey.shade700,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


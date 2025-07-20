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



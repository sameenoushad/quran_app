import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.teal;

    return Scaffold(
      backgroundColor: themeColor.shade100,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Arabic App Title
            Text(
              'مصحف | نور القلب وطمأنينة الروح',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: themeColor.shade900,
                fontFamily: 'Amiri',
                height: 1.4,
              ),
            ),

            // English Subtitle under Arabic
            Text(
              'Quran | Light of the Heart & Peace of the Soul',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: themeColor.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 30),

            // App Message
            

            const SizedBox(height: 30),

            // Mosque Image with Teal Card Background
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: themeColor.shade700, // teal background for card
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: themeColor.withOpacity(0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/mosque.png',
                    height: 400,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Get Started Button
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor.shade700,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
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

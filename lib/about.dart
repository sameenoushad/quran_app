import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// App Logo or Quran Icon
            CircleAvatar(
              radius: 50,
              backgroundColor: isDark ? Colors.teal.shade700 : Colors.teal.shade100,
              child: const Icon(Icons.menu_book_rounded, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),

            /// App Name
            Text(
              'Qur’an App',
              style: GoogleFonts.amiri(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),

            const SizedBox(height: 8),

            /// Version
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[400] : Colors.grey[700],
              ),
            ),

            const SizedBox(height: 30),

            /// Description
            Text(
              'This app is built to help you read, understand, and reflect on the Holy Qur’an. It includes Surah details, audio recitation, translations, Qibla direction, prayer times, and more — all in a clean and user-friendly interface.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: theme.textTheme.bodyMedium?.color,
              ),
            ),

            const SizedBox(height: 30),

            /// Developer Info
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Developed By:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Samee Noushad\nCEO & Founder, Code Dazzle',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// Contact / Credits
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact & Feedback:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Email: support@codedazzle.com\nWebsite: www.codedazzle.com',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.grey[300] : Colors.grey[800],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_application_1/about.dart';
import 'package:flutter_application_1/contactform.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@codedazzle.com',
      query: Uri.encodeFull('subject=Quran App Support&body=Assalamu Alaikum,\n\nI need help with...'),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _launchWhatsApp() async {
    final String phone = '+923001234567'; // Change to your number
    final Uri uri = Uri.parse(
        'https://wa.me/$phone?text=Assalamu%20Alaikum,%20I%20need%20help%20with%20Quran%20App');

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchTelegram() async {
    final Uri uri = Uri.parse('https://t.me/codedazzle'); // Your Telegram link
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [

          /// About
          ListTile(
            leading: Icon(Icons.info_outline, color: theme.iconTheme.color),
            title: Text('About', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const About()));
            },
          ),
          const Divider(),

          /// Contact Form
          ListTile(
            leading: Icon(Icons.chat_bubble_outline, color: theme.iconTheme.color),
            title: Text('Contact Form', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ContactForm()));
            },
          ),
          const Divider(),

          /// Contact via Email
          ListTile(
            leading: Icon(Icons.email_outlined, color: theme.iconTheme.color),
            title: Text('Email Us', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: _launchEmail,
          ),
          const Divider(),

          /// WhatsApp
          ListTile(
            leading: Icon(Icons.send_rounded, color: Colors.green),
            title: Text('WhatsApp', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: _launchWhatsApp,
          ),
          const Divider(),

          /// Telegram
          ListTile(
            leading: Icon(Icons.send_rounded, color: Colors.blueAccent),
            title: Text('Telegram Channel', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            onTap: _launchTelegram,
          ),
        ],
      ),
    );
  }
}

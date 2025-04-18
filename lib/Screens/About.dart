import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child:
                  Icon(Icons.info_outline, size: 80, color: Color(0xFF582218)),
            ),
            const SizedBox(height: 20),
            const Text(
              "Tour Scan",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF582218)),
            ),
            const SizedBox(height: 10),
            Text(
              "Tour Scan is an innovative mobile application designed to enhance the experience of tourists by providing instant information about statues, landmarks, and other attractions. By using a smartphone camera, users can scan a monument or tourist site, and the app will recognize it, retrieving detailed historical and cultural information.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/generated/l10n.dart'; // Import localization

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white)),
        title: Text(
          S.of(context).about, // Localized string for "About"
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: kSecondaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tour Scan", // Localized string for "Tour Scan"
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF582218)),
            ),
            const SizedBox(height: 10),
            Text(
              S
                  .of(context)
                  .aboutTourScan, // Localized string for the description
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}

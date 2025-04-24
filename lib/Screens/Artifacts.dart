import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourscan/Widgets/custom_back_button.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/Widgets/text_to_speech_button.dart'; // Import the external TTS widget
import 'package:tourscan/generated/l10n.dart';

class ArtifactDetails extends StatelessWidget {
  final String title;
  final String imageUrl; // This will be either asset path or network URL
  final String description;
  final String arDescription; // Add a field for Arabic description

  const ArtifactDetails({
    super.key,
    required this.title,
    required this.imageUrl, // The image source (asset or network)
    required this.description,
    required this.arDescription, // Pass Arabic description as a parameter
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool isArabic = LanguageUtil.isArabic; // Check if language is Arabic

    // Check if the imageUrl is an asset or network URL
    bool isAssetImage = imageUrl.startsWith('assets/');

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Top image with title
              Container(
                height: screenHeight * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: isAssetImage
                        ? AssetImage(imageUrl) // If asset, use AssetImage
                        : NetworkImage(imageUrl)
                            as ImageProvider, // Else, use NetworkImage
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment:
                      isArabic ? Alignment.bottomRight : Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: GoogleFonts.oxanium(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 4.0,
                            color: Colors.black.withOpacity(0.9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom content with description
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, -2),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description title
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                S
                                    .of(context)
                                    .description, // Use localized string
                                style: GoogleFonts.oxanium(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            // External Text-to-Speech widget used here
                            TextToSpeechButton(text: description),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Description content
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              isArabic
                                  ? arDescription
                                  : description, // Fetch the correct description
                              style: GoogleFonts.oxanium(
                                fontSize: 15.0,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Back button positioned at the top-left
          CustomBackButton(
            isArabic: isArabic,
          ),
        ],
      ),
    );
  }
}

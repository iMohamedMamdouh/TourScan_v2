import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/Widgets/text_to_speech_button.dart'; // Import the external TTS widget
import 'package:tourscan/generated/l10n.dart';

class Pyramids extends StatefulWidget {
  final PostsModel? postsModel;
  const Pyramids({super.key, this.postsModel});

  @override
  State<Pyramids> createState() => _PyramidsState();
}

class _PyramidsState extends State<Pyramids> {
  @override
  Widget build(BuildContext context) {
    // If postsModel is null, show a fallback UI.
    if (widget.postsModel == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No data available.',
            style: GoogleFonts.oxanium(fontSize: 18, color: Colors.black54),
          ),
        ),
      );
    }

    final screenHeight = MediaQuery.of(context).size.height;
    bool isArabic = LanguageUtil.isArabic;

    // Select title and description based on language.
    String title = isArabic
        ? (widget.postsModel!.arTitle ?? widget.postsModel!.title ?? '')
        : (widget.postsModel!.title ?? '');
    String description = isArabic
        ? (widget.postsModel!.arDescription ??
            widget.postsModel!.description ??
            '')
        : (widget.postsModel!.description ?? '');

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
                    image: NetworkImage(widget.postsModel!.imgPath ?? ''),
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
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                S.of(context).description,
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
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              description,
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
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: isArabic ? null : 10,
            right: isArabic ? 10 : null,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF582218),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

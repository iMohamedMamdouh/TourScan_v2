import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/generated/l10n.dart';

class Pyramids extends StatefulWidget {
  final PostsModel? postsModel;
  const Pyramids({super.key, this.postsModel});

  @override
  State<Pyramids> createState() => _PyramidsState();
}

class _PyramidsState extends State<Pyramids> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage(LanguageUtil.isArabic ? 'ar' : 'en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
    setState(() {
      isSpeaking = true;
    });
  }

  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    bool isArabic = LanguageUtil.isArabic;

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
                    image: NetworkImage(widget.postsModel!.imgPath!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
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
                            IconButton(
                              icon: Icon(
                                isSpeaking ? Icons.stop : Icons.volume_up,
                                color: const Color(0xFF582218),
                              ),
                              onPressed: () {
                                if (isSpeaking) {
                                  _stop();
                                } else {
                                  _speak(description);
                                }
                              },
                            ),
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

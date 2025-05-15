import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Widgets/custom_back_button.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/Widgets/text_to_speech_button.dart';
import 'package:tourscan/generated/l10n.dart';

class StatuesScreen extends StatefulWidget {
  final PostsModel? postsModel;
  const StatuesScreen({super.key, this.postsModel});

  @override
  State<StatuesScreen> createState() => _StatuesScreenState();
}

class _StatuesScreenState extends State<StatuesScreen> {
  @override
  Widget build(BuildContext context) {
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

    String title = isArabic
        ? (widget.postsModel!.arTitle ?? widget.postsModel!.title ?? '')
        : (widget.postsModel!.title ?? '');
    String description = isArabic
        ? (widget.postsModel!.arDescription ??
            widget.postsModel!.description ??
            '')
        : (widget.postsModel!.description ?? '');
    String imagePath = widget.postsModel!.imgPath ?? '';

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Image with title at bottom
              SizedBox(
                height: screenHeight * 0.5,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImage(imagePath),
                    Container(
                      alignment: isArabic
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                      child: Text(
                        title,
                        style: GoogleFonts.oxanium(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Description section
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
          CustomBackButton(isArabic: isArabic),
        ],
      ),
    );
  }

  /// Helper method to build network or asset image
  Widget _buildImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
              child: CircularProgressIndicator(
            color: kSecondaryColor,
          ));
        },
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
        ),
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Icon(Icons.broken_image, color: Colors.grey, size: 40),
        ),
      );
    }
  }
}

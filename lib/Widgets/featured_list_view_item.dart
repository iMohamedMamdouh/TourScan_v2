import 'package:flutter/material.dart';
import 'package:tourscan/Screens/Artifacts.dart';

class FeaturedListViewItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description; // Added description parameter

  const FeaturedListViewItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description, // Initialize description
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to ArtifactDetails screen on tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArtifactDetails(
              title: title,
              imageUrl: imageUrl,
              description: description, // Pass description
            ),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              // Title at the bottom
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black45,
                          offset: Offset(0, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

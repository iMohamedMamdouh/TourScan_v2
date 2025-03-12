import 'package:flutter/material.dart';
import 'package:tourscan/Screens/EgyptMuseumPage.dart';

class EgyptianMuseum extends StatelessWidget {
  const EgyptianMuseum({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EgyptMuseumPage(
              imgPath: 'assets/16a04dd4bd365e859919801c65f396ab.jpeg',
              title: 'Egyptian Museum',
              description:
                  'The Egyptian Museum in Cairo (EMC) is the oldest archaeological museum in the Middle East, housing over 170,000 artefacts. It has the largest collection of Pharaonic antiquities in the world.\n\nThe Museum’s exhibits span the Pre-Dynastic Period till the Graeco-Roman Era (c. 5500 BC - AD 364).',
            ),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        width: 380,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Image(
                image:
                    AssetImage("assets/16a04dd4bd365e859919801c65f396ab.jpeg"),
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              const Positioned(
                bottom: 16,
                left: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Egyptian Museum",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Egypt, Giza",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

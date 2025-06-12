import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tourscan/Screens/Artifacts.dart';
import 'package:tourscan/generated/l10n.dart';

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
            builder: (context) => ArtifactDetails(
              arDescription:
                  "يُعد المتحف المصري بالقاهرة أقدم متحف أثري في الشرق الأوسط، إذ يضم أكثر من 170,000 قطعة أثرية. ويضم أكبر مجموعة من الآثار الفرعونية في العالم. تمتد معروضات المتحف من عصر ما قبل الأسرات وحتى العصر اليوناني الروماني (حوالي 5500 قبل الميلاد - 364 ميلادي).",
              imageUrl: 'assets/Egyptian_muesum.jpeg',
              title: S.of(context).egyptianMuseum,
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
                image: AssetImage("assets/Egyptian_muesum.jpeg"),
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
              Positioned(
                bottom: 16,
                left: isArabic() ? null : 16,
                right: isArabic() ? 16 : null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).egyptianMuseum,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      S.of(context).giza,
                      style: const TextStyle(
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

bool isArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

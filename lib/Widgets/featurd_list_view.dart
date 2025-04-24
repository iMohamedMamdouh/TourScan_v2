import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Widgets/language_util.dart';

import 'featured_list_view_item.dart';

class FeaturedMuseumListView extends StatefulWidget {
  const FeaturedMuseumListView({super.key});

  @override
  State<FeaturedMuseumListView> createState() => _FeaturedMuseumListViewState();
}

class _FeaturedMuseumListViewState extends State<FeaturedMuseumListView> {
  @override
  void initState() {
    super.initState();
    LanguageUtil.languageCodeNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    LanguageUtil.languageCodeNotifier.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {}); // Trigger rebuild when the language changes
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2, // Adjusted height
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Artifacts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Artifacts Found"));
          }

          var artifacts = snapshot.data!.docs;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: artifacts.length,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              var artifact = artifacts[index].data(); // Cast the data to a Map

              // Use Arabic title if the locale is Arabic, otherwise use the default title
              String title = LanguageUtil.isArabic
                  ? (artifact["arTitle"] ??
                      "بدون عنوان") // Default to Arabic title or "بدون عنوان"
                  : (artifact["title"] ??
                      "Untitled"); // Default to English title or "Untitled"

              // Fetch Arabic description if language is Arabic, else fallback to default description
              String description = LanguageUtil.isArabic
                  ? (artifact["arDescription"] ??
                      "لا يوجد وصف") // Default to Arabic description or "لا يوجد وصف"
                  : (artifact["description"] ??
                      "No description available"); // Default to English description

              // Ensure the image URL exists
              String imageUrl = artifact["image"] ??
                  ""; // Default to an empty string if no image URL is found

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FeaturedListViewItem(
                  arDescription: artifact["arDescription"] ?? "",
                  title: title,
                  imageUrl: imageUrl,
                  description: description, // Use the correct description
                ),
              );
            },
          );
        },
      ),
    );
  }
}

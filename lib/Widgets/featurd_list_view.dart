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
              var artifact = artifacts[index].data();

              // Use Arabic title if the locale is Arabic, otherwise use the default title
              String title = LanguageUtil.isArabic
                  ? artifact["arTitle"] ?? "بدون عنوان"
                  : artifact["title"] ?? "Untitled";

              // Set the style for Arabic text as bold
              TextStyle titleStyle = LanguageUtil.isArabic
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : const TextStyle(fontWeight: FontWeight.normal);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FeaturedListViewItem(
                  title: title,
                  imageUrl: artifact["image"] ?? "",
                  description:
                      artifact["description"] ?? "No description available",
                ),
              );
            },
          );
        },
      ),
    );
  }
}

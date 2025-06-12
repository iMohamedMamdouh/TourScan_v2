import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Widgets/language_util.dart';

import 'featured_list_view_item.dart';

class FeaturedMuseumListView extends StatefulWidget {
  const FeaturedMuseumListView({
    super.key,
  });

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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2, // Adjusted height
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Artifacts").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: kSecondaryColor,
            ));
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

              String title = LanguageUtil.isArabic
                  ? (artifact["arTitle"] ?? "بدون عنوان")
                  : (artifact["title"] ?? "Untitled");

              String description = LanguageUtil.isArabic
                  ? (artifact["arDescription"] ?? "لا يوجد وصف")
                  : (artifact["description"] ?? "No description available");

              String imageUrl = artifact["image"] ?? "";

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FeaturedListViewItem(
                  arDescription: artifact["arDescription"] ?? "",
                  title: title,
                  imageUrl: imageUrl,
                  description: description,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'featured_list_view_item.dart';

class FeaturedMuseumListView extends StatelessWidget {
  const FeaturedMuseumListView({super.key});

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

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: FeaturedListViewItem(
                  title: artifact["title"] ?? "Untitled",
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

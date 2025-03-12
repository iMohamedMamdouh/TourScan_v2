import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Screens/pyramids.dart';
import 'package:tourscan/main.dart';

class StatueListTile extends StatelessWidget {
  const StatueListTile({
    super.key,
    required this.post,
  });

  final PostsModel post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await FirebaseFirestore.instance.collection('history').doc().set({
          'post_id': post.id!,
          'user_id': sharedpref!.getString('uid'),
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pyramids(postsModel: post),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF3F8F9), // Background color
                borderRadius: BorderRadius.circular(
                    16), // Apply border radius to the container
              ),
              child: Row(
                children: [
                  // Adding shadow to the image
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4), // Shadow position
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        post.imgPath!,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      post.title ?? 'No Title',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff424242),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black54),
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('history')
                          .doc()
                          .set({
                        'post_id': post.id!,
                        'user_id': sharedpref!.getString('uid'),
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pyramids(postsModel: post),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

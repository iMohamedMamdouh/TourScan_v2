import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Screens/statuesScreen.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/main.dart';

class StatueListTile extends StatelessWidget {
  const StatueListTile({
    super.key,
    required this.post,
  });

  final PostsModel post;

  @override
  Widget build(BuildContext context) {
    // Determine if the language is Arabic
    bool isArabic = LanguageUtil.isArabic;
    final bool isAssetImage =
        post.imgPath != null && post.imgPath!.startsWith('assets/');

    return InkWell(
      onTap: () async {
        await FirebaseFirestore.instance.collection('history').doc().set({
          'post_id': post.id!,
          'user_id': sharedpref!.getString('uid'),
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StatuesScreen(postsModel: post),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffF3F8F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Image with shadow
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: isAssetImage
                          ? Image.asset(
                              post.imgPath!,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: post.imgPath ?? '',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: kSecondaryColor,
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Title and Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isArabic
                              ? post.arTitle ?? 'بدون عنوان'
                              : post.title ?? 'No Title',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff424242),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          isArabic
                              ? post.arDescription ?? 'لا توجد وصف'
                              : post.description ?? 'No Description',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Styled Icon Button
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, bottom: 12.0, top: 24, left: 12.0),
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xffE5EBED),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Color(0xFF424242),
                        ),
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
                              builder: (context) => StatuesScreen(
                                postsModel: post,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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

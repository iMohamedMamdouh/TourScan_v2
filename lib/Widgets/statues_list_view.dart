import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Widgets/status_list_tile.dart';

class StatuesListView extends StatelessWidget {
  const StatuesListView({
    super.key,
    required this.postsModel,
  });

  final List<PostsModel> postsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 265,
      decoration: const BoxDecoration(
        color: kBackGroundColor, // Replace with kBackGroundColor if defined
      ),
      child: ListView.builder(
        itemCount: postsModel.length,
        padding: const EdgeInsets.symmetric(vertical: 9),
        itemBuilder: (BuildContext context, int index) {
          return StatueListTile(post: postsModel[index]);
        },
      ),
    );
  }
}

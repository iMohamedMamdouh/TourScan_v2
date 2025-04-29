import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Widgets/status_list_tile.dart';
import 'package:tourscan/generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  final List<PostsModel> allModel;
  const SearchScreen({super.key, required this.allModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<PostsModel> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.allModel;
  }

  void _search(String value) {
    setState(() {
      filteredList = widget.allModel
          .where((item) =>
              item.title != null &&
              item.title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _search,
          decoration: InputDecoration(
            hintText: S.of(context).Search,
            hintStyle: const TextStyle(color: kSecondaryColor),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: kSecondaryColor),
        ),
        iconTheme: const IconThemeData(color: kSecondaryColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Displaying posts in a list view
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return StatueListTile(post: item);
              },
            ),
          ],
        ),
      ),
    );
  }
}

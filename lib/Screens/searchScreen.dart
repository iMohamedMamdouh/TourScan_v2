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
      final query = value.trim().toLowerCase();
      filteredList = widget.allModel.where((item) {
        final locale = Localizations.localeOf(context).languageCode;
        final title = locale == 'ar'
            ? item.arTitle?.toLowerCase() ?? ''
            : item.title?.toLowerCase() ?? '';
        return title.contains(query);
      }).toList();
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
          textDirection: Localizations.localeOf(context).languageCode == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
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
            filteredList.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).NoResultsFound,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
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

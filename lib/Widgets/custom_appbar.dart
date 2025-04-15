import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/Login.dart';
import 'package:tourscan/generated/l10n.dart';

import '../MODELS/Postlmodel.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<PostsModel> postsModel;
  final List<PostsModel> allModel;
  final Function getPlaces;
  final bool isLoggedIn;

  const CustomAppBar({
    super.key,
    required this.postsModel,
    required this.allModel,
    required this.getPlaces,
    required this.isLoggedIn, // Pass login status
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      elevation: 0,
      title: Row(
        children: [
          // Menu Icon
          Builder(
            builder: (context) {
              return IconButton(
                icon: const ImageIcon(
                  AssetImage('assets/menu.png'),
                  color: kSecondaryColor,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          const SizedBox(width: 40),

          // Search Box
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xffE5EBED),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                textAlign: TextAlign.start,
                onChanged: (val) async {
                  setState(() {
                    widget.postsModel.clear();

                    if (val.isEmpty) {
                      widget.getPlaces();
                    } else {
                      widget.postsModel.addAll(
                        widget.allModel.where(
                          (searchItem) =>
                              searchItem.title != null &&
                              searchItem.title!
                                  .toLowerCase()
                                  .contains(val.toLowerCase()),
                        ),
                      );
                    }
                  });
                },
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search, color: kSecondaryColor),
                  contentPadding: const EdgeInsets.only(top: 8),
                  hintText: S.of(context).Search,
                  hintStyle: const TextStyle(color: kSecondaryColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Login Button (Only visible when not logged in)
          if (!widget.isLoggedIn)
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
              },
              child: Text(
                S.of(context).login,
                style: const TextStyle(
                  color: Color(0xFF582218),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

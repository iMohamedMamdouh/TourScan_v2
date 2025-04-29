import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/Login.dart';
import 'package:tourscan/Screens/searchScreen.dart';
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
            child: InkWell(
              onTap: () async {
                final allPosts = await widget.getPlaces();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchScreen(allModel: allPosts),
                  ),
                );
              },
              child: Ink(
                decoration: BoxDecoration(
                  color: const Color(0xffE5EBED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Search,
                        style: const TextStyle(
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Icon(Icons.search, color: kSecondaryColor),
                    ],
                  ),
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

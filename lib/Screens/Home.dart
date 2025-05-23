import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/Scaning.dart';
import 'package:tourscan/Widgets/build_drawer.dart';
import 'package:tourscan/Widgets/custom_appbar.dart';
import 'package:tourscan/Widgets/egyptian_muesum.dart';
import 'package:tourscan/Widgets/featurd_list_view.dart';
import 'package:tourscan/Widgets/statues_list_view.dart';
import 'package:tourscan/generated/l10n.dart';

import '../MODELS/Postlmodel.dart';

//test
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoggedIn = user != null;
    });

    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        isLoggedIn = user != null;
      });
    });
  }

  Future<List<PostsModel>> getPlaces() async {
    List<PostsModel> postsModel = [];
    try {
      // Fetch statues from Firestore
      QuerySnapshot querySnapshotStatues =
          await FirebaseFirestore.instance.collection('Statues').get();
      if (querySnapshotStatues.docs.isNotEmpty) {
        for (int x = 0; x < querySnapshotStatues.docs.length; x++) {
          Map<String, dynamic> statueData =
              querySnapshotStatues.docs[x].data() as Map<String, dynamic>;
          PostsModel post = PostsModel(
            id: querySnapshotStatues.docs[x].id,
            name: '',
            imgPath: statueData['image'] ?? '',
            title: statueData['title'] ?? '',
            arTitle: statueData['arTitle'] ?? '',
            isFav: false,
            description: statueData['description'] ?? '',
            arDescription: statueData['arDescription'] ?? '',
            isPlaces: false,
          );
          postsModel.add(post);
        }
      }
    } catch (e) {
      print('Error fetching places: $e');
    }
    return postsModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: CustomAppBar(
        postsModel: const [],
        allModel: const [],
        getPlaces: getPlaces,
        isLoggedIn: isLoggedIn, // Pass the login state
      ),
      drawer: const BuildDrawer(),
      body: FutureBuilder<List<PostsModel>>(
        future: getPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: kSecondaryColor,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            List<PostsModel> postsModel = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF582218)),
                    ),
                    Text(
                      S.of(context).subtitle,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xFFB0B0B0)),
                    ),
                    const SizedBox(height: 16),
                    const EgyptianMuseum(),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).artifacts,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF582218)),
                    ),
                    const SizedBox(height: 16),
                    const FeaturedMuseumListView(),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).statues,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF582218)),
                    ),
                    StatuesListView(postsModel: postsModel),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanningPage()),
          );
        },
        backgroundColor: kSecondaryColor,
        child: const ImageIcon(
          color: Color(0xffE5EBED),
          AssetImage('assets/Group.png'),
        ),
      ),
    );
  }
}

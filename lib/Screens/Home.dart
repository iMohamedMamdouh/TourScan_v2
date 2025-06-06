import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/Screens/Scaning.dart';
import 'package:tourscan/Widgets/build_drawer.dart';
import 'package:tourscan/Widgets/custom_appbar.dart';
import 'package:tourscan/Widgets/egyptian_muesum.dart';
import 'package:tourscan/Widgets/featurd_list_view.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/Widgets/statues_list_view.dart';
import 'package:tourscan/generated/l10n.dart';
import 'package:tourscan/utils/animation_utils.dart';

import '../MODELS/Postlmodel.dart';

//test
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool isLoggedIn = false;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
    _initializeFabAnimation();
  }

  void _initializeFabAnimation() {
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    ));

    // Start FAB animation after a delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _fabController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
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
                child: StaggeredListAnimation(
                  itemDelay: const Duration(milliseconds: 150),
                  children: [
                    const SizedBox(height: 16),
                    Align(
                      alignment: LanguageUtil.isArabic
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        S.of(context).title,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF582218)),
                        textAlign: LanguageUtil.isArabic
                            ? TextAlign.right
                            : TextAlign.left,
                      ).fadeIn(delay: const Duration(milliseconds: 200)),
                    ),
                    Align(
                      alignment: LanguageUtil.isArabic
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        S.of(context).subtitle,
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xFFB0B0B0)),
                        textAlign: LanguageUtil.isArabic
                            ? TextAlign.right
                            : TextAlign.left,
                      ).fadeIn(delay: const Duration(milliseconds: 400)),
                    ),
                    const SizedBox(height: 16),
                    const EgyptianMuseum().slideIn(
                      delay: const Duration(milliseconds: 600),
                      direction: SlideDirection.left,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: LanguageUtil.isArabic
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        S.of(context).artifacts,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF582218)),
                        textAlign: LanguageUtil.isArabic
                            ? TextAlign.right
                            : TextAlign.left,
                      ).slideIn(
                        delay: const Duration(milliseconds: 800),
                        direction: SlideDirection.right,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const FeaturedMuseumListView().slideIn(
                      delay: const Duration(milliseconds: 1000),
                      direction: SlideDirection.bottom,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: LanguageUtil.isArabic
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Text(
                        S.of(context).statues,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF582218)),
                        textAlign: LanguageUtil.isArabic
                            ? TextAlign.right
                            : TextAlign.left,
                      ).slideIn(
                        delay: const Duration(milliseconds: 1200),
                        direction: SlideDirection.left,
                      ),
                    ),
                    StatuesListView(postsModel: postsModel).slideIn(
                      delay: const Duration(milliseconds: 1400),
                      direction: SlideDirection.bottom,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          onPressed: () {
            Navigator.push(
              context,
              CustomPageRoute(
                child: const ScanningPage(),
                transitionType: PageTransitionType.slideUp,
              ),
            );
          },
          backgroundColor: kSecondaryColor,
          child: const ImageIcon(
            color: Color(0xffE5EBED),
            AssetImage('assets/Group.png'),
          ),
        ),
      ),
    );
  }
}

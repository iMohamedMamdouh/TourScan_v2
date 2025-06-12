import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tourscan/Constans/Const.dart';
import 'package:tourscan/MODELS/Postlmodel.dart';
import 'package:tourscan/Widgets/language_util.dart';
import 'package:tourscan/Widgets/status_list_tile.dart';
import 'package:tourscan/generated/l10n.dart';

class SearchScreen extends StatefulWidget {
  final List<PostsModel> allModel;
  const SearchScreen({super.key, required this.allModel});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  List<PostsModel> filteredList = [];
  List<PostsModel> filteredStatues = [];
  List<PostsModel> filteredArtifacts = [];
  bool _showSearchBar = false;
  late TabController _tabController;
  String _currentSearchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredList = widget.allModel;
    _tabController = TabController(length: 2, vsync: this);

    // Listen to tab changes but don't close search bar automatically
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Apply current search to the new tab
        _applySearchToCurrentTab(_currentSearchQuery);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _search(String value) {
    setState(() {
      _currentSearchQuery = value;
      final query = value.trim().toLowerCase();

      // Search in all models for general search
      filteredList = widget.allModel.where((item) {
        final locale = Localizations.localeOf(context).languageCode;
        final title = locale == 'ar'
            ? item.arTitle?.toLowerCase() ?? ''
            : item.title?.toLowerCase() ?? '';
        return title.contains(query);
      }).toList();

      // Apply search to current tab if in category view
      if (!_showSearchBar) {
        _applySearchToCurrentTab(query);
      }
    });
  }

  void _applySearchToCurrentTab(String query) {
    // This will trigger the StreamBuilder to rebuild with filtered results
    setState(() {
      _currentSearchQuery = query;
    });
  }

  void _toggleSearchBar() {
    setState(() {
      _showSearchBar = !_showSearchBar;
      if (_showSearchBar) {
        // When opening search bar, clear category-specific filters
        _controller.text = _currentSearchQuery;
      }
    });
  }

  Widget _buildStatuesTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Statues").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: kSecondaryColor),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              S.of(context).NoResultsFound,
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        var statues = snapshot.data!.docs;

        // Convert to PostsModel and apply search filter
        List<PostsModel> statuesList = statues.map((doc) {
          var statue = doc.data() as Map<String, dynamic>;
          return PostsModel(
            id: doc.id,
            title: statue['title'] ?? '',
            arTitle: statue['arTitle'] ?? '',
            description: statue['description'] ?? '',
            arDescription: statue['arDescription'] ?? '',
            imgPath: statue['image'] ?? '',
            name: statue['name'] ?? '',
          );
        }).toList();

        // Apply search filter if there's a search query
        if (_currentSearchQuery.isNotEmpty) {
          final query = _currentSearchQuery.toLowerCase();
          final locale = Localizations.localeOf(context).languageCode;

          statuesList = statuesList.where((item) {
            final title = locale == 'ar'
                ? item.arTitle?.toLowerCase() ?? ''
                : item.title?.toLowerCase() ?? '';
            return title.contains(query);
          }).toList();
        }

        if (statuesList.isEmpty && _currentSearchQuery.isNotEmpty) {
          return Center(
            child: Text(
              S.of(context).NoResultsFound,
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: statuesList.length,
          itemBuilder: (context, index) {
            return StatueListTile(post: statuesList[index]);
          },
        );
      },
    );
  }

  Widget _buildArtifactsTab() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Artifacts").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: kSecondaryColor),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              S.of(context).NoResultsFound,
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        var artifacts = snapshot.data!.docs;

        // Convert to PostsModel and apply search filter
        List<PostsModel> artifactsList = artifacts.map((doc) {
          var artifact = doc.data() as Map<String, dynamic>;
          return PostsModel(
            id: doc.id,
            title: artifact['title'] ?? '',
            arTitle: artifact['arTitle'] ?? '',
            description: artifact['description'] ?? '',
            arDescription: artifact['arDescription'] ?? '',
            imgPath: artifact['image'] ?? '',
            name: artifact['name'] ?? '',
          );
        }).toList();

        // Apply search filter if there's a search query
        if (_currentSearchQuery.isNotEmpty) {
          final query = _currentSearchQuery.toLowerCase();
          final locale = Localizations.localeOf(context).languageCode;

          artifactsList = artifactsList.where((item) {
            final title = locale == 'ar'
                ? item.arTitle?.toLowerCase() ?? ''
                : item.title?.toLowerCase() ?? '';
            return title.contains(query);
          }).toList();
        }

        if (artifactsList.isEmpty && _currentSearchQuery.isNotEmpty) {
          return Center(
            child: Text(
              S.of(context).NoResultsFound,
              style: const TextStyle(color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // Vertical display (1 column)
            childAspectRatio: 4.5, // Adjust aspect ratio for better appearance
            mainAxisSpacing: 8.0,
          ),
          itemCount: artifactsList.length,
          itemBuilder: (context, index) {
            return StatueListTile(post: artifactsList[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = LanguageUtil.isArabic;

    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: TextField(
          controller: _controller,
          autofocus: false,
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          onChanged: _search,
          decoration: InputDecoration(
            hintText: S.of(context).Search,
            hintStyle: const TextStyle(color: kSecondaryColor),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search, color: kSecondaryColor),
              onPressed: () {
                // Optional: You can add functionality here if needed
              },
            ),
          ),
          style: const TextStyle(color: kSecondaryColor),
        ),
        iconTheme: const IconThemeData(color: kSecondaryColor),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: kSecondaryColor,
          labelColor: kSecondaryColor,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: isArabic ? 'التماثيل' : 'Statues',
              icon: const Icon(Icons.account_balance),
            ),
            Tab(
              text: S.of(context).artifacts,
              icon: const Icon(Icons.museum),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStatuesTab(),
          _buildArtifactsTab(),
        ],
      ),
    );
  }
}

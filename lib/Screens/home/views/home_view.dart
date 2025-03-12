// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tourscan/Screens/Scaning.dart';

// class HomeeView extends StatelessWidget {
//   const HomeeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Image.asset(
//               'assets/menu.png', // مسار الصورة
//               width: 26, // تعديل الحجم حسب الحاجة
//               height: 26,
//               fit: BoxFit.contain,
//             ),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//         title: Container(
//           width: 220,
//           height: 50,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: TextField(
//             controller: _searchController,
//             textAlign: TextAlign.start,
//             onChanged: (val) async {
//               postsModel.clear();
//               if (val.isEmpty) {
//                 getPlaces();
//               } else {
//                 postsModel.addAll(allModel.where((searchItem) => searchItem
//                     .title!
//                     .toLowerCase()
//                     .contains(val.toLowerCase())));
//               }
//               setState(() {});
//             },
//             decoration: InputDecoration(
//               hintText: "Search...",
//               hintStyle: TextStyle(color: Colors.brown.shade900),
//               suffixIcon: Icon(Icons.search, color: Colors.brown.shade900),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey.shade200,
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//             ),
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Login()),
//               );
//             },
//             child: const Text(
//               "Login",
//               style: TextStyle(
//                   color: Color(0xFF582218), fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.white, // جعل الخلفية بالكامل بيضاء
//               padding: const EdgeInsets.only(
//                   top: 50, bottom: 20), // مسافة علوية وسفلية
//               child: Column(
//                 children: [
//                   // صورة الحساب
//                   const Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CircleAvatar(
//                         radius: 70, // تكبير الخلفية
//                         backgroundImage:
//                             AssetImage("assets/profile1.png"), // الخلفية
//                       ),
//                       CircleAvatar(
//                         radius: 50, // تصغير الصورة فوق الخلفية
//                         backgroundColor:
//                             Colors.transparent, // إزالة أي لون خلفي
//                         backgroundImage:
//                             AssetImage("assets/profile2.png"), // الصورة الشخصية
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15), // مسافة بعد الصورة

//                   // اسم المستخدم
//                   const Text(
//                     "User Name",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const SizedBox(height: 5), // مسافة بين الاسم والإيميل

//                   // الإيميل
//                   Text(
//                     "user@example.com",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey[600],
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                   const SizedBox(height: 15), // مسافة قبل الخط الفاصل

//                   // الخط الفاصل الرمادي
//                   Divider(
//                     thickness: 1,
//                     color: Colors.grey.shade300,
//                     indent: 30,
//                     endIndent: 30,
//                   ),
//                 ],
//               ),
//             ),

//             // القائمة الرئيسية
//             Expanded(
//               child: ListView(
//                 children: [
//                   ListTile(
//                     leading: const Icon(Icons.home, color: Color(0xFF582218)),
//                     title: const Text("Home"),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomePage()));
//                     },
//                   ),
//                   ListTile(
//                     leading:
//                         const Icon(Icons.settings, color: Color(0xFF582218)),
//                     title: const Text("Settings"),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => SettingsPage()));
//                     },
//                   ),
//                   ListTile(
//                     leading: Image.asset(
//                       'assets/rocketchat-brands-solid 1.png',
//                       width: 24,
//                       height: 24,
//                       fit: BoxFit.contain,
//                     ),
//                     title: const Text("Ask"),
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ChatListScreen()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.info, color: Color(0xFF582218)),
//                     title: const Text("About"),
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => AboutPage()));
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // زر تسجيل الخروج في الأسفل
//             Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: ListTile(
//                 leading: const Icon(Icons.logout, color: Color(0xFF582218)),
//                 title: const Text("Logout"),
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Startedscreen()));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Welcome To Tour Scan",
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF582218)),
//               ),
//               const SizedBox(height: 5),
//               Text(
//                 "Find your Next Adventure",
//                 style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
//               ),
//               const SizedBox(height: 20),
//               Stack(
//                 children: [
//                   // الصورة مع زوايا دائرية
//                   ClipRRect(
//                     borderRadius:
//                         BorderRadius.circular(25), // زوايا دائرية قوية
//                     child: SizedBox(
//                       width: 538,
//                       height: 227,
//                       child: Image.asset(
//                         "assets/16a04dd4bd365e859919801c65f396ab.jpeg",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),

//                   // النصوص داخل مستطيل شفاف
//                   Positioned(
//                     bottom: 10, // وضع النصوص قرب أسفل الصورة
//                     left: 20,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 8),
//                       decoration: BoxDecoration(
//                         color:
//                             Colors.black26, // تفتيح الخلفية أكثر لجعلها ناعمة
//                         borderRadius: BorderRadius.circular(12), // زوايا ناعمة
//                       ),
//                       child: Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.start, // المحاذاة لليسار
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Egyptian Museum',
//                             style: GoogleFonts.inter(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white, // العنوان بالأبيض
//                             ),
//                           ),
//                           Text(
//                             'Egypt, Giza',
//                             style: GoogleFonts.inter(
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.grey[300], // لون أفتح قليلاً
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),
//               // بقية الكود الخاص بعرض الـ Category و Explore...
//               const Text(
//                 "Artifacts",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF582218)),
//               ),
//               Container(
//                 width: 300,
//                 height: 196,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white70,
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("Artifacts")
//                         .snapshots(),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                         return const Center(child: Text("No Artifacts Found"));
//                       }

//                       var artifacts = snapshot.data!.docs;

//                       return ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: artifacts.length,
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         itemBuilder: (context, index) {
//                           var artifact = artifacts[index].data();

//                           return InkWell(
//                             onTap: () async {
//                               await FirebaseFirestore.instance
//                                   .collection('history')
//                                   .add({
//                                 'post_id': artifacts[index].id,
//                                 'user_id': sharedpref!.getString('uid'),
//                               });

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ArtifactDetails(
//                                     title: artifact["title"],
//                                     imageUrl: artifact["image"],
//                                     description: artifact["description"],
//                                   ),
//                                 ),
//                               );
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: FillImageCard(
//                                 width: 200,
//                                 heightImage: 100,
//                                 color: Colors.grey.shade300,
//                                 imageProvider: NetworkImage(artifact["image"]),
//                                 description: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           artifact["title"],
//                                           style: const TextStyle(
//                                             fontSize: 15.0,
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width:
//                                               MediaQuery.sizeOf(context).width *
//                                                   .22,
//                                           child: Text(
//                                             artifact["description"],
//                                             overflow: TextOverflow.ellipsis,
//                                             style: const TextStyle(
//                                               fontSize: 10.0,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 10),
//               const SizedBox(height: 20),
//               const Text(
//                 "Statues",
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF582218)),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 400,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                 ),
//                 child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: postsModel.length,
//                   padding: const EdgeInsets.symmetric(vertical: 9),
//                   itemBuilder: (BuildContext context, int index) {
//                     return InkWell(
//                       onTap: () async {
//                         await FirebaseFirestore.instance
//                             .collection('history')
//                             .doc()
//                             .set({
//                           'post_id': postsModel[index].id!,
//                           'user_id': sharedpref!.getString('uid'),
//                         });
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 Pyramids(postsModel: postsModel[index]),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: Image.network(
//                                     postsModel[index].imgPath!,
//                                     width: 70,
//                                     height: 70,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         postsModel[index].name!,
//                                         style: const TextStyle(
//                                           fontSize: 15.0,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Text(
//                                         postsModel[index].title!,
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 1,
//                                         style: const TextStyle(
//                                           fontSize: 12.0,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.arrow_forward_ios,
//                                       color: Colors.black54),
//                                   onPressed: () async {
//                                     await FirebaseFirestore.instance
//                                         .collection('history')
//                                         .doc()
//                                         .set({
//                                       'post_id': postsModel[index].id!,
//                                       'user_id': sharedpref!.getString('uid'),
//                                     });
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => Pyramids(
//                                             postsModel: postsModel[index]),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Divider(color: Colors.grey.shade400),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: Align(
//         alignment: Alignment.bottomRight,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ScanningPage()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF582218),
//               fixedSize: const Size(60, 60),
//               padding: EdgeInsets.zero, // إزالة الـ padding الافتراضي
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Center(
//               child: Image.asset(
//                 'assets/Group.png', // مسار الصورة
//                 width: 35, // تعديل الحجم حسب الحاجة
//                 height: 35,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
//     );
//   }
// }

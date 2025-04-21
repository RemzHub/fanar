// import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
// import 'package:fanar/core/network/api_constants.dart';
// import 'package:fanar/core/theme/theme_controller.dart';
// import 'package:fanar/features/auth/controller/auth_controller.dart';
// import 'package:fanar/features/auth/logic/model/profile.dart';
// import 'package:fanar/features/profile/view/screens/upload_gallery_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ProfileScreen extends StatelessWidget {
//   final int id;
//   const ProfileScreen({
//     super.key,
//     required this.id,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final double appBarHeight = kToolbarHeight; // Default AppBar height is 56.0
//     final double statusBarHeight = MediaQuery.of(context).padding.top;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: ThemeController().themeGradient,
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(
//             top: appBarHeight + statusBarHeight,
//             left: 16.0,
//             right: 16.0,
//           ),
//           child: FutureBuilder(
//             future: Future.delayed(Durations.medium1),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return DefaultTabController(
//                   length: 2,
//                   child: Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 56.0,
//                         backgroundImage: CachedNetworkImageProvider(
//                           ApiConstants.previewProfileImage(
//                               profile.profileImage),
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       SizedBox(
//                         height: 50,
//                         child: TabBar(
//                           labelColor: Theme.of(context).colorScheme.secondary,
//                           indicatorColor:
//                               Theme.of(context).colorScheme.secondary,
//                           unselectedLabelColor: Colors.grey,
//                           dividerColor: Colors.grey,
//                           tabs: [
//                             Tab(icon: Icon(Icons.grid_on)),
//                             Tab(icon: Icon(Icons.person)),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: TabBarView(
//                           children: [
//                             Stack(
//                               alignment: Alignment.bottomCenter,
//                               children: [
//                                 GetBuilder<AuthController>(
//                                   builder: (userController) {
//                                     return GridView.builder(
//                                       padding: EdgeInsets.only(
//                                         bottom: 48.0,
//                                       ),
//                                       gridDelegate:
//                                           SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 3,
//                                         childAspectRatio: 1.3 / 2,
//                                         crossAxisSpacing: 2.0,
//                                         mainAxisSpacing: 2.0,
//                                       ),
//                                       itemCount:
//                                           userController.user.gallery.length,
//                                       itemBuilder: (context, index) {
//                                         final image =
//                                             userController.user.gallery[index];

//                                         return GestureDetector(
//                                           onTap: () => Get.dialog(
//                                             Dialog(
//                                               child: CachedNetworkImage(
//                                                 imageUrl:
//                                                     ApiConstants.mediaPreview(
//                                                   image.path,
//                                                 ),
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                           ),
//                                           child: Stack(
//                                             alignment: Alignment.topLeft,
//                                             children: [
//                                               CachedNetworkImage(
//                                                 width: double.infinity,
//                                                 height: double.infinity,
//                                                 imageUrl:
//                                                     ApiConstants.mediaPreview(
//                                                   image.path,
//                                                 ),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                               if (image.userId ==
//                                                   userController.user.id)
//                                                 Container(
//                                                   height: 32,
//                                                   width: 32,
//                                                   margin: EdgeInsets.only(
//                                                     top: 4.0,
//                                                     left: 4.0,
//                                                   ),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.red,
//                                                     shape: BoxShape.circle,
//                                                   ),
//                                                   child: Center(
//                                                     child: IconButton(
//                                                       padding: EdgeInsets.zero,
//                                                       onPressed: () {
//                                                         userController
//                                                             .deleteMedia(
//                                                                 image.id);
//                                                       },
//                                                       icon: Icon(
//                                                         Icons.delete,
//                                                         size: 18.0,
//                                                         color: Theme.of(context)
//                                                             .colorScheme
//                                                             .secondary,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   },
//                                 ),
//                                 CustomElevatedButton(
//                                   label: 'أرفع صورة جديدة',
//                                   borderRadiusCircular: 0.0,
//                                   backgroundColor: Colors.blueGrey,
//                                   onPressed: () {
//                                     Get.toNamed(UploadGalleryImage.routeName);
//                                   },
//                                 ),
//                               ],
//                             ),
//                             GetBuilder<AuthController>(
//                               builder: (authController) {
//                                 final profile = authController.user.profile
//                                     as PerformerProfile;

//                                 return Column(
//                                   children: [
//                                     Text(
//                                       profile.firstName,
//                                       style: TextStyle(
//                                         fontSize: 24.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.middleName,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.lastName,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.bio,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.gender.name,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.generalRole.name,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.nationality.name,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.residenceCountry.name,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 16.0),
//                                     Text(
//                                       profile.residenceCity.name,
//                                       style: TextStyle(
//                                         fontSize: 16.0,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .secondary,
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ProfileListTile extends StatelessWidget {
//   final String title;
//   final IconData suffixIcon;
//   final VoidCallback onTap;
//   const ProfileListTile({
//     required this.title,
//     required this.suffixIcon,
//     required this.onTap,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => onTap(),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.secondary,
//                   fontSize: 18.0,
//                 ),
//               ),
//               Icon(
//                 suffixIcon,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//             ],
//           ),
//           const SizedBox(height: 4.0),
//           Divider(
//             color: Theme.of(context).colorScheme.secondary,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:fanar/core/common/widgets/custom_elevated_button.dart';
import 'package:fanar/core/network/api_constants.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/auth/logic/model/profile.dart';
import 'package:fanar/features/profile/view/screens/edit_profile_screen.dart';
import 'package:fanar/features/profile/view/screens/update_profile_image_screen.dart';
import 'package:fanar/features/profile/view/screens/upload_gallery_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: GetBuilder<AuthController>(
              builder: (userController) {
                print(userController.user.profile?.profileImage.toString());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            CircleAvatar(
                              radius: 56.0,
                              backgroundImage: CachedNetworkImageProvider(
                                ApiConstants.previewProfileImage(
                                    userController.user.profile!.profileImage),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Get.toNamed(UpdateProfileImageScreen.routeName);
                              },
                              icon: Icon(
                                Icons.upload,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 32.0),
                            ProfileListTile(
                              title: 'تعديل الملف الشخصي',
                              suffixIcon: Icons.account_box,
                              onTap: () =>
                                  Get.toNamed(EditProfileScreen.routeName),
                            ),
                            const SizedBox(height: 32.0),
                            ProfileListTile(
                              title: 'تسجيل خروج',
                              suffixIcon: Icons.logout,
                              onTap: AuthController.to.logout,
                            ),
                            const SizedBox(height: 32.0),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 50,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.secondary,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelColor: Colors.grey,
              dividerColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.video_collection)),
                Tab(icon: Icon(Icons.person)),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GetBuilder<AuthController>(
                      builder: (userController) {
                        return GridView.builder(
                          padding: EdgeInsets.only(
                            bottom: 48.0,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1.3 / 2,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                          ),
                          itemCount: userController.user.gallery.length,
                          itemBuilder: (context, index) {
                            final image = userController.user.gallery[index];

                            return GestureDetector(
                              onTap: () => Get.dialog(
                                Dialog(
                                  child: CachedNetworkImage(
                                    imageUrl: ApiConstants.mediaPreview(
                                      image.path,
                                    ),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  CachedNetworkImage(
                                    width: double.infinity,
                                    height: double.infinity,
                                    imageUrl: ApiConstants.mediaPreview(
                                      image.path,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  if (image.userId == userController.user.id)
                                    Container(
                                      height: 32,
                                      width: 32,
                                      margin: EdgeInsets.only(
                                        top: 4.0,
                                        left: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            userController
                                                .deleteMedia(image.id);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 18.0,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    CustomElevatedButton(
                      label: 'أرفع صورة جديدة',
                      borderRadiusCircular: 0.0,
                      backgroundColor: Colors.blueGrey,
                      onPressed: () {
                        Get.toNamed(UploadGalleryImage.routeName);
                      },
                    ),
                  ],
                ),
                Center(child: Text("Videos Content")),
                GetBuilder<AuthController>(
                  builder: (authController) {
                    final profile =
                        authController.user.profile as PerformerProfile;

                    return Column(
                      children: [
                        Text(
                          profile.firstName,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.middleName,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.lastName,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.bio,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.gender.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.generalRole.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.nationality.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.residenceCountry.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          profile.residenceCity.name,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData suffixIcon;
  final VoidCallback onTap;
  const ProfileListTile({
    required this.title,
    required this.suffixIcon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18.0,
                ),
              ),
              Icon(
                suffixIcon,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}

import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/ai/view/widgets/ai_widget.dart';
import 'package:fanar/features/application/logic/application_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/courses/view/widgets/courses_widget.dart';
import 'package:fanar/features/home/logic/homepage_controller.dart';
import 'package:fanar/features/home/view/widgets/homepage_widget.dart';
import 'package:fanar/features/opportunity/view/widgets/opportunity_widget.dart';
import 'package:fanar/features/profile/view/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageScreen extends StatefulWidget {
  static const String routeName = '/homepage_screen';
  // final HomepageController controller = Get.put(HomepageController());

  const HomepageScreen({super.key});

  static const _pages = [
    HomepageWidget(),
    CoursesWidget(),
    AIWidget(),
    OpportunityWidget(),
    ProfileWidget(),
  ];

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  @override
  void initState() {
    ApplicationController.to.fetchPerformerApplications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default appBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return GetBuilder<HomepageController>(
      init: HomepageController(),
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            controller.currentIndex == 4
                ? AuthController.to.user.username.toUpperCase()
                : 'بُـــعـد',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.mail,
                color: Theme.of(context).colorScheme.secondary,
              ),
              iconSize: 24.0,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: Colors.amber,
              ),
              iconSize: 24.0,
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(
            top: appBarHeight + statusBarHeight,
          ),
          decoration: BoxDecoration(
            gradient: ThemeController().themeGradient,
          ),
          child: HomepageScreen._pages[controller.currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF0F2027),
          currentIndex: controller.currentIndex,
          onTap: (index) {
            controller.updateIndex(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(
                icon: Icon(Icons.theater_comedy), label: "دوراتي"),
            BottomNavigationBarItem(
                icon: Icon(Icons.memory, size: 40), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "فرصي"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "حسابي"),
          ],
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

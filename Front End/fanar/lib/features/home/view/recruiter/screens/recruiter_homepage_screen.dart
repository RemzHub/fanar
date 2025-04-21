import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/auth/controller/auth_controller.dart';
import 'package:fanar/features/home/logic/homepage_controller.dart';
import 'package:fanar/features/home/view/recruiter/widgets/recruiter_homepage_widget.dart';
import 'package:fanar/features/opportunity/view/recruiter/screens/recruiter_opportunities_screen.dart';
import 'package:fanar/features/opportunity/view/recruiter/widgets/recruiter_opportunity_widget.dart';
import 'package:fanar/features/profile/view/recruiter/widgets/recruiter_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecruiterHomepageScreen extends StatelessWidget {
  static const String routeName = '/recruiter_homepage_screen';
  // final HomepageController controller = Get.put(HomepageController());

  const RecruiterHomepageScreen({super.key});

  static const _pages = [
    RecruiterHomepageWidget(),
    RecruiterOpportunityWidget(),
    RecruiterOpportunities(),
    RecruiterProfileWidget(),
  ];

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
          child: _pages[controller.currentIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xFF0F2027),
          currentIndex: controller.currentIndex,
          onTap: (index) {
            controller.updateIndex(index);
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: "الفرص"),
            BottomNavigationBarItem(icon: Icon(Icons.inbox), label: "الطلبات"),
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

import 'package:fanar/core/theme/theme_controller.dart';
import 'package:fanar/features/application/logic/application_controller.dart';
import 'package:fanar/features/application/view/widgets/application_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationsScreen extends StatelessWidget {
  static const String routeName = '/applications-screen';
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double appBarHeight = kToolbarHeight;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: appBarHeight + statusBarHeight,
            left: 16.0,
            right: 16.0,
          ),
          child: GetBuilder<ApplicationController>(
            builder: (controller) => RefreshIndicator(
              onRefresh: () => controller.fetchPerformerApplications(),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: controller.performerApplication.length,
                itemBuilder: (context, index) {
                  final application = controller.performerApplication[index];
                  return ApplicationCard(
                    application: application,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

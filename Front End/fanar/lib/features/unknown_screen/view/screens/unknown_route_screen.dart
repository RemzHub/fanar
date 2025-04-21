import 'package:fanar/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';

class UnknownRouteScreen extends StatelessWidget {
  static const String routeName = '/unknown_route_screen';

  const UnknownRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AppBar height
    final double appBarHeight = kToolbarHeight; // Default AppBar height is 56.0
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Ops!"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: ThemeController().themeGradient,
        ),
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight + statusBarHeight),
            child: Text(
              'This page does not exist! \n (Error 404)',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

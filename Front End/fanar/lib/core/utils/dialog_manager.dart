import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogManager {
  // Private constructor
  DialogManager._();

  // Private instance of the class
  static final _instance = DialogManager._();

  // Factory constructor to return the single instance
  factory DialogManager() {
    return _instance;
  }

  // if context needed
  // BuildContext? _context;
  // set context(val) => _context = val;

  void showDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.brown,
        title: Text(
          title,
        ),
        content: Text(
          message,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            //blockButton: true,
            child: Text(
              'Ok',
            ),
          ),
        ],
      ),
    );
  }

  void showSnackBar(String title, String message) {
    Get.closeAllSnackbars();
    Get.snackbar(
      title,
      message,
      colorText: Colors.white70,
      animationDuration: Duration(milliseconds: 400),
      duration: Duration(milliseconds: 3200),
    );
  }
}

/*

import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

class DialogManager {
  

  void showSnackbar(String title, String message) {
     Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
    );
  }

  void showDialog(String title, String message) {

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.brown,
        title:  TextPlus(title, color: Colors.white, fontSize: 30,),
        content:  TextPlus(message , color: Colors.white, fontSize: 22,),
        actions: [
          GFButton(
              onPressed: () {
                Get.back();
              },
              size: GFSize.LARGE,
              color: Colors.brown.shade800,
              //blockButton: true,
              child: TextPlus('Ok', fontSize: 24, color: Colors.white,),
            ),
        ],
      ),
    );
  }
}
 */

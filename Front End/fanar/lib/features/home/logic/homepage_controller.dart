import 'package:get/get.dart';

class HomepageController extends GetxController {
  static HomepageController get to => Get.find();

  int currentIndex = 0;

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }
}

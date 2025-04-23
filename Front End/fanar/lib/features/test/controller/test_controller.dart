import 'package:get/get.dart';

class TestController extends GetxController {
  static TestController get to => Get.find();

  int currentIndex = 1;

  void updateIndex(int index) {
    currentIndex = index;
    update();
  }
}

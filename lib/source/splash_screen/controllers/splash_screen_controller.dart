import 'package:app/source/home/screens/home_screen_widget.dart';
import 'package:app/source/initialization/screens/language_screen_widget.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation(int stateId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 2500));
    if (stateId == 0) {
      Get.off(LangScreen());
    } else if (stateId == 1) {
      //Home
      Get.off(Home());
    }
  }
}

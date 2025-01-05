import 'dart:ui';
import 'package:app/source/authentication/screens/signin_or_register_screen_widget.dart';
import 'package:app/source/initialization/screens/gender_screen_widget.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:get/get.dart';

class InitController extends GetxController {
  RxBool isMaleSelected = false.obs;
  RxBool isFemaleSelected = false.obs;
  RxBool isSinhalaSelected = false.obs;
  RxBool isTamilSelected = false.obs;
  RxBool isEnglishSelected = false.obs;

  maleSelected() async {
    isMaleSelected.value = !isMaleSelected.value;
    await LocalDbManager.saveData('2', 1);
    Get.off(const SigninOrRegister());
  }

  femaleSelected() async {
    isFemaleSelected.value = !isFemaleSelected.value;
    await LocalDbManager.saveData('2', 2);
    Get.off(const SigninOrRegister());
  }

  sinhalaSelected() async {
    isSinhalaSelected.value = !isSinhalaSelected.value;
    await LocalDbManager.saveData('1', 1);
    Get.updateLocale(const Locale('si', 'LK'));
    Get.to(InitScreen(language: 1));
  }

  tamilSelected() async {
    isTamilSelected.value = !isTamilSelected.value;
    await LocalDbManager.saveData('1', 2);
    Get.updateLocale(const Locale('en', 'US'));
    Get.to(InitScreen(language: 2));
  }

  englishSelected() async {
    isEnglishSelected.value = !isEnglishSelected.value;
    await LocalDbManager.saveData('1', 2);
    Get.updateLocale(const Locale('en', 'US'));
    Get.to(InitScreen(language: 2));
  }
}

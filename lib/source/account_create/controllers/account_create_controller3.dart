import 'package:get/get.dart';

class AccountCreateController3 extends GetxController {
  List<String>? eduAchi;
  List<String>? eduPlcs;
  List<String>? hobbies;

  int? myEduLvel;
  int? prefEduLevl;

  eduOnChaged(int? value) {
    myEduLvel = value;
  }

  prefEduOnChaged(int? value) {
    prefEduLevl = value;
  }

  eduAchiOkOnPressed(String text) {
    eduAchi?.add(text);
    update();
  }

  eduPlcDialogOkOnPressed(String text) {
    eduPlcs?.add(text);
    update();
  }

  eduAchiDeletOnPressed(String item) {
    eduAchi?.remove(item);
    update();
  }

  eduPlcDeletOnPressed(String item) {
    eduPlcs?.remove(item);
  }

  hobbiesDialogOkOnPressed(String text) {
    hobbies?.add(text);
    update();
  }

  hobbiesDeletOnPressed(String item) {
    hobbies?.remove(item);
    update();
  }

  onCancle() {
    Get.back();
  }
}

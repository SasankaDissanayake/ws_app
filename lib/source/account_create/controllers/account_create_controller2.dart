import 'package:get/get.dart';

class AccoutCreateController2 extends GetxController {
  int? myMarraige;
  int? preMarraigeStatus;
  int? kids;
  int? haveKids;
  List<String> selectedQualities = [];
  int? district;
  int? race;
  int? religion;

  updateDistrict(int? value) {
    district = value!;
  }

  updateRace(int? value) {
    race = value!;
  }

  updateReligion(int? value) {
    religion = value!;
  }

  updateMyMarraige(int? value) {
    myMarraige = value!;
    update();
  }

  updatePreMarraigeStatus(int? value) {
    preMarraigeStatus = value!;
    update();
  }

  updateKids(int? value) {
    kids = value!;
    update();
  }

  updateHaveKids(int? value) {
    haveKids = value!;
    update();
  }

  add(String item) {
    selectedQualities.add(item);
    update();
  }

  remove(String item) {
    selectedQualities.remove(item);
    update();
  }
}

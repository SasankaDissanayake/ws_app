import 'package:get/get.dart';

class AccountCreateController1 extends GetxController {
  DateTime? birthday;
  int? accountFor;
  int? gender;
  String? description;
  int? sameCasteSearch;
  bool? sameCasteSearching;
  int? myCaste;
  int? selectedHeightFt;
  int? selectedHeightInch;

  updateAccFor(int? value) {
    accountFor = value!;
    update();
  }

  updateMyCaste(int? value) {
    myCaste = value!;
  }

  updateGender(int? value) {
    gender = value!;
    update();
  }

  updateSameCasteSearch(int? value) {
    sameCasteSearch = value!;
    sameCasteSearching = sameCasteSearch == 0 ? true : false;
    update();
  }

  updateHeightFt(int ft) {
    selectedHeightFt = ft;
    update();
  }

  updateHeightInch(int inch) {
    selectedHeightInch = inch;
    update();
  }
}

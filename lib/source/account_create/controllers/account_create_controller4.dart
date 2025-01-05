import 'package:get/get.dart';

class AccountCreateController4 extends GetxController {
  int? myDrinkingHabs;
  int? mySmokingHabs;
  int? prefDrinkingHabs;
  int? prefSmokingHabs;

  drinkingHabOnChaged(int? value) {
    myDrinkingHabs = value;
    update();
  }

  smokingHabOnChaged(int? value) {
    mySmokingHabs = value;
    update();
  }

  prefDrinkingHabOnChaged(int? value) {
    prefDrinkingHabs = value;
    update();
  }

  prefSmokingHabOnChaged(int? value) {
    prefSmokingHabs = value;
    update();
  }
}

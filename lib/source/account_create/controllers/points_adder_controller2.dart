import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PointAdderController2 extends GetxController {
  List<String> userInput = [];

  deletOnPressed(String item) {
    userInput.remove(item);
    update();
  }

  dialogOkOnPressed(String item) {
    userInput.add(item);
    update();
  }
}

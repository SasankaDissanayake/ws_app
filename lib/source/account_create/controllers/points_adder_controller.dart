import 'package:get/get.dart';

class PointAdderController extends GetxController {
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

import 'package:app/source/account_create/controllers/points_adder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class PointsAdder extends StatelessWidget {
  final PointAdderController controller = Get.put(PointAdderController());
  final TextEditingController text = TextEditingController();
  final box = GetStorage();
  final String dialogTitleText;
  final String dialogHint;
  final String dialogLabel;
  final String target;

  final List<String>? userInput;

  final Icon icon;

  PointsAdder({
    super.key,
    required this.dialogTitleText,
    required this.dialogHint,
    required this.dialogLabel,
    required this.userInput,
    required this.icon,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
      child: Column(
        children: [
          GetBuilder<PointAdderController>(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<PointAdderController>(builder: (_) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: onPressed, icon: const Icon(Icons.add)),
                      Text(
                        "Add",
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  );
                }),
              ],
            );
          }),
          GetBuilder<PointAdderController>(builder: (_) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.userInput
                    .map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              children: [
                                icon,
                                Text(" $item"),
                                IconButton(
                                  onPressed: () async {
                                    controller.deletOnPressed(item);
                                    await box.write(
                                        target, controller.userInput);
                                  },
                                  icon: const Icon(
                                    Icons.close_outlined,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          })
        ],
      ),
    );
  }

  onPressed() {
    Get.defaultDialog(
      title: dialogTitleText,
      content: TextField(
        controller: text,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          hintText: dialogHint,
          labelText: dialogLabel,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            text.clear();
            Get.back();
          },
          child: const Text(
            "Cancle",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (text.text.isNotEmpty) {
              controller.dialogOkOnPressed(text.text);
              text.clear();
              Get.back();
              await box.write(target, controller.userInput);
            }
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.blueAccent),
          ),
        )
      ],
    );
  }
}

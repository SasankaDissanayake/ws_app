import 'package:app/source/my_profile/controllers/account_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PointsAdderEduPlc extends StatelessWidget {
  final AccountManager controller = Get.put(AccountManager());
  final TextEditingController text = TextEditingController();

  PointsAdderEduPlc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
      child: Column(
        children: [
          GetBuilder<AccountManager>(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<AccountManager>(builder: (_) {
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
          GetBuilder<AccountManager>(builder: (_) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.eduPlcs
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
                                const Icon(Icons.business_sharp),
                                Text(" $item"),
                                IconButton(
                                  onPressed: () async {
                                    controller.eduPlcsDeletOnPressed(item);
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
      title: "Educated places",
      content: TextField(
        controller: text,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          hintText: "Enter your educated places here!",
          labelText: "Educated places",
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
              controller.eduPlcsDialogOnPressed(text.text);
            }
            Get.back();
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

class PointsAdderEduAchives extends StatelessWidget {
  final AccountManager controller = Get.put(AccountManager());
  final TextEditingController text = TextEditingController();

  PointsAdderEduAchives({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 15, left: 15),
      child: Column(
        children: [
          GetBuilder<AccountManager>(builder: (_) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<AccountManager>(builder: (_) {
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
          GetBuilder<AccountManager>(builder: (_) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.eduAchis
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
                                const Icon(Icons.school),
                                Text(" $item"),
                                IconButton(
                                  onPressed: () async {
                                    controller.eduAchivDeletOnPressed(item);
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
      title: "Educatinal achievements",
      content: TextField(
        controller: text,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          hintText: "Enter your educatinal achievements here!",
          labelText: "Educatinal achievements",
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
              controller.eduAchisDialogOnPressed(text.text);
            }
            Get.back();
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

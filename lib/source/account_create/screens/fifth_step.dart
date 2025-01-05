import 'package:app/source/account_create/controllers/account_create_controller2.dart';
import 'package:app/source/account_create/screens/sixth_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class FifthStep extends StatelessWidget {
  final AccoutCreateController2 controller = Get.put(AccoutCreateController2());

  final String name;
  final String phoneNumber;
  final String fullName;
  final String promo;
  final DateTime birthday;
  final int accountFor;
  final int gender;
  final String description;
  final bool sameCasteSearch;
  final int myCaste;
  final int inch;
  final int ft;
  final int myMarraige;
  final int prefMarraige;
  final int kids;
  late final TutorialCoachMark tutorial;

  FifthStep({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.fullName,
    required this.promo,
    required this.birthday,
    required this.accountFor,
    required this.gender,
    required this.description,
    required this.sameCasteSearch,
    required this.myCaste,
    required this.inch,
    required this.ft,
    required this.myMarraige,
    required this.prefMarraige,
    required this.kids,
  });

  final int maxSelections = 3;
  final GlobalKey _titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;
    createTutorial(isEnglish);
    startTut(context);
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 40,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tell us what you value in a person",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 27,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  key: _titleKey,
                  "Which qualities speak to your soul? Choose 3 that would make a connection that much stronger.",
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Their qualities",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                GetBuilder<AccoutCreateController2>(
                  builder: (_) => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: qualities.map((quality) {
                      final isSelected =
                          controller.selectedQualities.contains(quality);
                      return ChoiceChip(
                        label: Text(quality),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            if (controller.selectedQualities.length <
                                maxSelections) {
                              controller.add(quality);
                            }
                          } else {
                            controller.remove(quality);
                          }
                        },
                        selectedColor: isDark ? Colors.white : Colors.black,
                        backgroundColor: isDark ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: isSelected ? Colors.white : Colors.black,
                            width: 2,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        avatar: isSelected
                            ? const Icon(Icons.checklist_rtl,
                                color: Colors.white, size: 20)
                            : null,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPressed();
        },
        backgroundColor: isDark ? Colors.white : Colors.black,
        shape: const CircleBorder(),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 30,
          color: isDark ? Colors.black : Colors.white,
        ),
      ),
    );
  }

  onPressed() {
    if (controller.selectedQualities.length == 3) {
      Get.off(SixthStep(
        name: name,
        phoneNumber: phoneNumber,
        fullName: fullName,
        promo: promo,
        birthday: birthday,
        accountFor: accountFor,
        gender: gender,
        description: description,
        sameCasteSearch: sameCasteSearch,
        myCaste: myCaste,
        inch: inch,
        ft: ft,
        myMarraige: myMarraige,
        prefMarraige: prefMarraige,
        kids: kids,
        qualities: controller.selectedQualities,
      ));
    }
  }

  Future<void> createTutorial(bool isEnglish) async {
    final targets = [
      TargetFocus(
        identify: 'qualitiesfield',
        keyTarget: _titleKey,
        alignSkip: Alignment.bottomCenter,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.yellowAccent),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'qulTit'.tr,
                  style: TextStyle(
                    fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    ];

    tutorial = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
    );
  }

  startTut(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000));
    tutorial.show(context: context);
  }
}

import 'package:app/source/account_create/components/drop_down_field.dart';
import 'package:app/source/account_create/components/point_adder.dart';
import 'package:app/source/account_create/components/point_adder2.dart';
import 'package:app/source/account_create/controllers/account_create_controller3.dart';
import 'package:app/source/account_create/screens/eighth_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class SeventhStep extends StatelessWidget {
  final AccountCreateController3 controller =
      Get.put(AccountCreateController3());
  final box = GetStorage();

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
  final List<String> qualities;
  final int district;
  final int race;
  final int religion;

  SeventhStep({
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
    required this.qualities,
    required this.district,
    required this.race,
    required this.religion,
  });

  late final TutorialCoachMark tutorial;
  final GlobalKey _titleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    String eduPlc = "eduPlc";
    String eduAchve = "eduAchve";
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;
    createTutorial(isEnglish);
    startTut(context);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key: _titleKey,
                    "Tell us about your educatinal background",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    "Your educatinal level",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownField(
                      dropDownList: eduLevel,
                      onChanged: controller.eduOnChaged),
                  const SizedBox(height: 20),
                  Text(
                    "Your educatinal achievements",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  GetBuilder<AccountCreateController3>(builder: (_) {
                    return PointsAdder(
                      target: eduAchve,
                      dialogTitleText:
                          'Enter your educatinal achievements here!',
                      dialogHint: 'Enter your educatinal achievements!',
                      dialogLabel: 'Educatinal Achievements',
                      userInput: controller.eduAchi,
                      icon: const Icon(Icons.school),
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    "Your educated places",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  GetBuilder<AccountCreateController3>(builder: (_) {
                    return PointsAdder2(
                      target: eduPlc,
                      dialogTitleText: 'Enter your educated places here!',
                      dialogHint: 'Enter your educated places!',
                      dialogLabel: 'Educated places',
                      userInput: controller.eduPlcs,
                      icon: const Icon(Icons.business_sharp),
                    );
                  }),
                  const SizedBox(height: 20),
                  Text(
                    "Partner preferred minimum education level",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownField(
                    dropDownList: prefMinEduLevel,
                    onChanged: controller.prefEduOnChaged,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onPressed(eduPlc, eduAchve);
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

  onPressed(String eduPlc, String eduAchve) async {
    if (controller.myEduLvel != null && controller.prefEduLevl != null) {
      final eduPlce = await box.read(eduPlc);
      final eduAchv = await box.read(eduAchve);

      Get.off(EighthStep(
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
        qualities: qualities,
        district: district,
        race: race,
        religion: religion,
        myEduLvel: controller.myEduLvel!,
        prefEduLevl: controller.prefEduLevl!,
        eduAchi: (eduAchv != null) ? eduAchv as List<String> : [],
        eduPlcs: (eduPlce != null) ? eduPlce as List<String> : [],
      ));

      await box.remove(eduPlc);
      await box.remove(eduAchve);
    } else {
      Get.snackbar(
        'Fields are empty',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> createTutorial(bool isEnglish) async {
    final targets = [
      TargetFocus(
        identify: 'edufields',
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
                  'edu'.tr,
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

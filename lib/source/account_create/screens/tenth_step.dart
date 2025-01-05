import 'package:app/source/account_create/controllers/account_create_controller4.dart';
import 'package:app/source/account_create/screens/eleventh_op_one_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TenthStep extends StatelessWidget {
  final AccountCreateController4 controller =
      Get.put(AccountCreateController4());

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
  final int myEduLvel;
  final int prefEduLevl;
  final List<String> eduAchi;
  final List<String> eduPlcs;
  final String jobPos;
  final String workPlc;
  final int mySmokes;
  final int myDrinks;

  TenthStep({
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
    required this.myEduLvel,
    required this.prefEduLevl,
    required this.eduAchi,
    required this.eduPlcs,
    required this.jobPos,
    required this.workPlc,
    required this.mySmokes,
    required this.myDrinks,
  });

  late final TutorialCoachMark tutorial;
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
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key: _titleKey,
                "Tell us your preferred drinking and smoking habits in a partner",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                "Partner preferred drinking habits",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < partPrefDrinkHabs.length; i++) ...[
                    _buildDrinksOption(partPrefDrinkHabs[i], i, isDark),
                  ],
                ],
              ),
              const SizedBox(height: 35),
              Text(
                "Partner preferred smoking habits",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < partPrefSmokHabs.length; i++) ...[
                    _buildSmokeOption(partPrefSmokHabs[i], i, isDark),
                  ],
                ],
              ),
            ],
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

  Widget _buildDrinksOption(String label, int value, bool isDark) {
    return GetBuilder<AccountCreateController4>(builder: (_) {
      return Row(
        children: [
          Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.prefDrinkingHabs,
            onChanged: (int? newValue) =>
                controller.prefDrinkingHabOnChaged(newValue),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: isDark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: 17.5,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSmokeOption(String label, int value, bool isDark) {
    return GetBuilder<AccountCreateController4>(builder: (_) {
      return Row(
        children: [
          Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.prefSmokingHabs,
            onChanged: (int? newValue) =>
                controller.prefSmokingHabOnChaged(newValue),
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: isDark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: 17.5,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      );
    });
  }

  onPressed() {
    if (controller.prefDrinkingHabs != null &&
        controller.prefSmokingHabs != null) {
      Get.off(EleventhOptionOneStep(
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
        myEduLvel: myEduLvel,
        prefEduLevl: prefEduLevl,
        eduAchi: eduAchi,
        eduPlcs: eduPlcs,
        jobPos: jobPos,
        workPlc: workPlc,
        mySmokes: mySmokes,
        myDrinks: myDrinks,
        prefSmokes: controller.prefSmokingHabs!,
        prefDrinks: controller.prefDrinkingHabs!,
      ));
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
        identify: 'prefHabsfields',
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
                  'prfHabs'.tr,
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

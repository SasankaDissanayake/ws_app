import 'package:app/source/account_create/controllers/account_create_controller2.dart';
import 'package:app/source/account_create/screens/fifth_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ForthStep extends StatelessWidget {
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
  late final TutorialCoachMark tutorial;

  ForthStep({
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
  });
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
                "Tell us more about your, Please?",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                "Your marraige status",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < marraigeStatus.length; i++) ...[
                    _buildMarraigeOption(marraigeStatus[i], i, isDark),
                  ],
                ],
              ),
              const SizedBox(height: 35),
              Text(
                "Partner preferred marraige status",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < prefferdMarraigeStatus.length; i++) ...[
                    _buildPrefMarraigeOption(
                        prefferdMarraigeStatus[i], i, isDark),
                  ],
                ],
              ),
              const SizedBox(height: 35),
              Text(
                "Kids?",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  for (int i = 0; i < kidsPreferences.length; i++) ...[
                    _buildPrefKidsOption(kidsPreferences[i], i, isDark),
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
          )),
    );
  }

  Widget _buildMarraigeOption(String label, int value, bool isDark) {
    return Row(
      children: [
        GetBuilder<AccoutCreateController2>(
          builder: (_) => Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.myMarraige,
            onChanged: (int? newValue) {
              controller.updateMyMarraige(newValue);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: isDark ? Colors.white : Colors.black,
          ),
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
  }

  Widget _buildPrefKidsOption(String label, int value, bool isDark) {
    return GetBuilder<AccoutCreateController2>(
      builder: (_) => Row(
        children: [
          Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.kids,
            onChanged: (int? newValue) {
              controller.updateKids(newValue);
            },
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
      ),
    );
  }

  Widget _buildPrefMarraigeOption(String label, int value, bool isDark) {
    return Row(
      children: [
        GetBuilder<AccoutCreateController2>(
          builder: (_) => Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.preMarraigeStatus,
            onChanged: (int? newValue) {
              controller.updatePreMarraigeStatus(newValue);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: isDark ? Colors.white : Colors.black,
          ),
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
  }

  onPressed() {
    if (controller.myMarraige != null &&
        controller.preMarraigeStatus != null &&
        controller.kids != null) {
      Get.off(FifthStep(
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
        myMarraige: controller.myMarraige!,
        prefMarraige: controller.preMarraigeStatus!,
        kids: controller.kids!,
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
        identify: 'marraigefield',
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
                  'maryTut'.tr,
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

import 'package:app/source/account_create/controllers/account_create_controller1.dart';
import 'package:app/source/account_create/screens/second_step_.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class FirstStep1 extends StatelessWidget {
  final AccountCreateController1 controller =
      Get.put(AccountCreateController1());

  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final GlobalKey _fullNameKey = GlobalKey();
  final GlobalKey _birthdayKey = GlobalKey();

  final String name;
  final String phoneNumber;
  final String promoCode;
  late final TutorialCoachMark tutorial;

  FirstStep1({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.promoCode,
  });

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
                "Hello there! Let's strat with an intro.",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 35),
              isEnglish
                  ? Text(
                      key: _fullNameKey,
                      "fNameTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      key: _fullNameKey,
                      "fNameTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              TextField(
                controller: _fullname,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              isEnglish
                  ? Text(
                      key: _birthdayKey,
                      "bdayTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      key: _birthdayKey,
                      "bdayTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              TextField(
                onTap: () => birthdayOnTap(context),
                controller: _birthday,
                readOnly: true,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.5,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              isEnglish
                  ? Text(
                      "genTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      "genTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildGenderOption("Male", 0, isDark),
                  const SizedBox(width: 20),
                  _buildGenderOption("Female", 1, isDark),
                ],
              ),
              const SizedBox(height: 30),
              isEnglish
                  ? Text(
                      "accForTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      "accForTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildAccForOption("For myself", 0, isDark),
                  const SizedBox(width: 20),
                  _buildAccForOption("For my child", 1, isDark),
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

  birthdayOnTap(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime(1995),
      firstDate: DateTime(1985),
      lastDate: DateTime(2005),
    ).then((value) {
      controller.birthday = value!;
      _birthday.text = controller.birthday.toString().split(" ")[0];
    });
  }

  Widget _buildGenderOption(String label, int value, bool isDark) {
    return GetBuilder<AccountCreateController1>(builder: (_) {
      return Row(
        children: [
          Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.gender,
            onChanged: (int? newValue) {
              controller.updateGender(value);
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
                color: isDark ? Colors.white : Colors.black),
          ),
        ],
      );
    });
  }

  Widget _buildAccForOption(String label, int value, bool isDark) {
    return GetBuilder<AccountCreateController1>(builder: (_) {
      return Row(
        children: [
          Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.accountFor,
            onChanged: (int? newValue) {
              controller.updateAccFor(value);
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
                color: isDark ? Colors.white : Colors.black),
          ),
        ],
      );
    });
  }

  onPressed() {
    if (_birthday.text.isNotEmpty &&
        (controller.gender != null) &&
        (controller.accountFor != null)) {
      if (_fullname.text.isEmpty) {
        _fullname.text = ' ';
      }
      Get.off(SecondStep(
          name: name,
          phoneNumber: phoneNumber,
          fullName: _fullname.text,
          promo: promoCode,
          birthday: controller.birthday!,
          accountFor: controller.accountFor!,
          gender: controller.gender!));
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
        identify: 'fullnamefield',
        keyTarget: _fullNameKey,
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
                  'fNameTut'.tr,
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
      TargetFocus(
        identify: 'bdayfield',
        keyTarget: _birthdayKey,
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
                  'bdayTut'.tr,
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

import 'package:app/source/account_create/screens/request_page.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class FirstStep extends StatelessWidget {
  FirstStep({super.key});
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phoneNum = TextEditingController();
  final TextEditingController _promoCode = TextEditingController();
  final GlobalKey _nameKey = GlobalKey();
  final GlobalKey _phoneNumKey = GlobalKey();
  final GlobalKey _promoKey = GlobalKey();
  late final TutorialCoachMark tutorial;

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
              isEnglish
                  ? Text(
                      "regTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      "regTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 15),
              isEnglish
                  ? Text(
                      "regExp".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      "regExp".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 35),
              isEnglish
                  ? Text(
                      key: _nameKey,
                      "nameTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      key: _nameKey,
                      "nameTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              TextField(
                controller: _name,
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
                      key: _phoneNumKey,
                      "phoneTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      key: _phoneNumKey,
                      "phoneTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              TextField(
                controller: _phoneNum,
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
              Text(
                "Promo code(Optinal)",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              TextField(
                controller: _promoCode,
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: isDark ? Colors.white : Colors.black,
          shape: const CircleBorder(),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: isDark ? Colors.black : Colors.white,
          ),),
    );
  }

  onPressed() {
    if (_name.text.isNotEmpty && _phoneNum.text.length > 8 && _phoneNum.text.isPhoneNumber) {
      Get.to(RequestPage(
        name: _name.text,
        phoneNumber: _phoneNum.text,
        promoCode: _promoCode.text,
      ));
    } else {
      Get.snackbar(
        'Fields are empty',
        'Also please enter valid phone number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> createTutorial(bool isEnglish) async {
    final targets = [
      TargetFocus(
        identify: 'namefield',
        keyTarget: _nameKey,
        alignSkip: Alignment.topCenter,
        // color: Colors.red,
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
                  'nameTut'.tr,
                  style: TextStyle(
                    fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      TargetFocus(
        identify: 'phonefield',
        keyTarget: _phoneNumKey,
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
                  'phoneTut'.tr,
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
        identify: 'promofield',
        keyTarget: _promoKey,
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
                  'promoTut'.tr,
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

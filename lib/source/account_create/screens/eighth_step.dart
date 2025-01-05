import 'package:app/source/account_create/controllers/account_create_controller3.dart';
import 'package:app/source/account_create/screens/ninth_step.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class EighthStep extends StatelessWidget {
  final AccountCreateController3 controller =
      Get.put(AccountCreateController3());

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

  EighthStep({
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
  });

  final TextEditingController _pos = TextEditingController();
  final TextEditingController _plc = TextEditingController();

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
                    "If you have job, tell us about it, Please?",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    "Job position",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _pos,
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
                  const SizedBox(height: 35),
                  Text(
                    "Work place",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _plc,
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
          ],
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

  onPressed() {
    if (_plc.text.isEmpty) {
      _plc.text = ' ';
    }
    if (_pos.text.isEmpty) {
      _pos.text = ' ';
    }
    Get.off(NinthStep(
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
      jobPos: _pos.text,
      workPlc: _plc.text,
    ));
  }

  Future<void> createTutorial(bool isEnglish) async {
    final targets = [
      TargetFocus(
        identify: 'jobfields',
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
                  'job'.tr,
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

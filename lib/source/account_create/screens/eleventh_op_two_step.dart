import 'package:app/source/account_create/screens/last_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:app/source/references/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EleventhOpTwoStep extends StatelessWidget {
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
  final int prefSmokes;
  final int prefDrinks;
  final List<String> imageUrls;

  EleventhOpTwoStep({
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
    required this.prefSmokes,
    required this.prefDrinks,
    required this.imageUrls,
  });

  final RxInt _selectedIndex = (-1).obs; // Initialize with -1 (no selection)

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;
    double width = Get.width;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 30,
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    isEnglish
                        ? Text(
                            "skinColor".tr,
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          )
                        : Text(
                            "skinColor".tr,
                            style: GoogleFonts.gemunuLibre(
                              fontWeight: FontWeight.w600,
                              fontSize: 23,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                  ],
                ),
              ),
              Center(
                child: Obx(
                  () => Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(skinColors.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _selectedIndex.value = index;
                        },
                        child: Container(
                          width: width - 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: skinColors[index],
                            border: Border.all(
                              color: _selectedIndex.value == index
                                  ? isDark
                                      ? Colors.white
                                      : Colors.black
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: floatingActionButtonOnPressed,
          backgroundColor: isDark ? Colors.white : Colors.black,
          shape: const CircleBorder(),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: isDark ? Colors.black : Colors.white,
          )),
    );
  }

  floatingActionButtonOnPressed() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    AccountModel account = AccountModel(
      userId: userId,
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
      prefSmokes: prefSmokes,
      prefDrinks: prefDrinks,
      imageUrls: imageUrls,
      skinColor: _selectedIndex.value,
      createdAt: Timestamp.fromDate(DateTime.now()),
    );
    Get.to(CreateProfile(profile: account));
  }
}

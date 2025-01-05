import 'package:app/source/account_create/controllers/image_picker_controller.dart';
// import 'package:app/source/account_create/screens/eleventh_op_two_step.dart';
import 'package:app/source/account_create/screens/last_step.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:app/source/references/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class EleventhOptionOneStep extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
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

  EleventhOptionOneStep({
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
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: isEnglish
                  ? Text(
                      "photoTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      "photoTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 33,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 10),
                child: Obx(() => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.65),
                      itemCount: controller.images.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            controller.images[index] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      controller.images[index]!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                : DottedBorder(
                                    // Wrap Placeholder with DottedBorder
                                    color: isDark ? Colors.white : Colors.black,
                                    strokeWidth: 3,
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(10),
                                    dashPattern: const [8, 8],
                                    child: Container(),
                                  ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: controller.images[index] != null
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 30,
                                      ),
                                      color: Colors.red,
                                      onPressed: () {
                                        controller.images.removeAt(index);
                                        controller.images.add(null);
                                      },
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.add,
                                        size: 30,
                                      ),
                                      color: Colors.amber.shade700,
                                      onPressed: () {
                                        controller.pickImages();
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEnglish
                      ? Text(
                          "noPhotos".tr,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        )
                      : Text(
                          "noPhotos".tr,
                          style: GoogleFonts.gemunuLibre(
                            fontWeight: FontWeight.w600,
                            fontSize: 23,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: noPhotosOnPressed,
                    child: Text(
                      "No photos",
                      style: GoogleFonts.comfortaa(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.black : Colors.white,
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
          onPressed(isDark);
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

  onPressed(bool isDark) async {
    bool hasImage = false;
    for (var i = 0; i < controller.images.length; i++) {
      if (controller.images[i] != null) {
        hasImage = true;
        break;
      }
    }

    if (hasImage) {
      Get.bottomSheet(
        Material(
          color: isDark ? Colors.black : Colors.white,
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Uploading images..",
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                color: isDark ? Colors.black : Colors.white,
                child: Center(
                  child: Lottie.asset(
                    loadingAnimation,
                    repeat: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      List<String> imageUrls = await controller.uploadImagesToFirebase();

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
        skinColor: -1,
        createdAt: Timestamp.fromDate(
          DateTime.now(),
        ),
      );
      Get.to(CreateProfile(profile: account));
    } else {
      Get.snackbar(
        'No image selected',
        'At least add one photo',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  noPhotosOnPressed() {
    // Get.off(EleventhOpTwoStep(
    //   name: name,
    //   phoneNumber: phoneNumber,
    //   fullName: fullName,
    //   promo: promo,
    //   birthday: birthday,
    //   accountFor: accountFor,
    //   gender: gender,
    //   description: description,
    //   sameCasteSearch: sameCasteSearch,
    //   myCaste: myCaste,
    //   inch: inch,
    //   ft: ft,
    //   myMarraige: myMarraige,
    //   prefMarraige: prefMarraige,
    //   kids: kids,
    //   qualities: qualities,
    //   district: district,
    //   race: race,
    //   religion: religion,
    //   myEduLvel: myEduLvel,
    //   prefEduLevl: prefEduLevl,
    //   eduAchi: eduAchi,
    //   eduPlcs: eduPlcs,
    //   jobPos: jobPos,
    //   workPlc: workPlc,
    //   mySmokes: mySmokes,
    //   myDrinks: myDrinks,
    //   prefSmokes: prefSmokes,
    //   prefDrinks: prefDrinks,
    //   imageUrls: const [],
    // ));
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
      imageUrls: [],
      skinColor: -1,
      createdAt: Timestamp.fromDate(DateTime.now()),
    );
    Get.to(CreateProfile(profile: account));
  }
}

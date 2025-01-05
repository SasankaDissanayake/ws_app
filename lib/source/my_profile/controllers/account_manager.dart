import 'package:app/source/my_profile/controllers/image_service.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:app/source/references/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountManager extends GetxController {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

  final ImageServiceController imagePickerController =
      Get.put(ImageServiceController());

  RxInt skinColor = (-1).obs;
  RxBool isLoading = false.obs;
  int? accountFor;
  bool? sameCasteSearching;
  String? caste;
  int? myCaste;
  DateTime? myBirthday;
  int? myGender;
  int? ft;
  int? inch;
  int? marraigeStatus;
  int? prefMarraigeStatus;
  int? haveKids;
  int? kids;
  int? district;
  int? race;
  int? religion;
  int? myEduLvel;
  int? prefEduLevl;
  int? myDrinkingHabits;
  int? mySmokingHabits;
  int? partnerPrefferedDrinkingHabits;
  int? partnerPrefferedSmokingHabits;
  String? phoneNumber;
  String? promo;
  Timestamp? createdAt;
  List<String>? preQualities;

  final TextEditingController name = TextEditingController();
  final TextEditingController birthday = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController town = TextEditingController();
  final TextEditingController jopPos = TextEditingController();
  final TextEditingController worlPlc = TextEditingController();
  final TextEditingController fullname = TextEditingController();

  List<String> eduPlcs = [];
  List<String> eduAchis = [];
  List<String> hobbies = [];

  accountForOnChanged(int? value) {
    accountFor = value!;
  }

  sameCasteSearchingOnChanged(int? value) {
    sameCasteSearching = value == 0 ? true : false;
    sameCasteSearching == true ? myCaste = null : myCaste = -1;
    update();
  }

  onHeightChanged(int? value) {
    String height = heights[value!];

    // Split the selected height into feet and inches
    List<String> parts = height.split("'");
    ft = int.parse(parts[0]);
    inch = int.parse(parts[1].replaceAll('"', ''));
    onHeightInited();
  }

  int onHeightInited() {
    String heihgt = "$ft'$inch\"";
    return heights.indexOf(heihgt);
  }

  marraigeStatusOnChanged(int? value) {
    marraigeStatus = value;
  }

  prefMarraigeStatusOnChanged(int? value) {
    prefMarraigeStatus = value;
  }

  haveKidsOnChanged(int? value) {
    haveKids = value;
  }

  kidsOnChanged(int? value) {
    kids = value;
  }

  districtOnChanged(int? value) {
    district = value;
  }

  raceOnChanged(int? value) {
    race = value;
  }

  religionOnChanged(int? value) {
    religion = value;
  }

  myEduLvelOnChanged(int? value) {
    myEduLvel = value;
  }

  prefEduLvelOnChanged(int? value) {
    prefEduLevl = value;
  }

  eduPlcsDialogOnPressed(String item) {
    eduPlcs.add(item);
    update();
  }

  eduAchisDialogOnPressed(String item) {
    eduAchis.add(item);
    update();
  }

  eduPlcsDeletOnPressed(String item) {
    eduPlcs.remove(item);
    update();
  }

  eduAchivDeletOnPressed(String item) {
    eduAchis.remove(item);
    update();
  }

  myCasteOnChanged(int? value) {
    myCaste = value;
  }

  myDrinkingHabitsOnChaged(int? value) {
    myDrinkingHabits = value;
  }

  mySmokingHabitsOnChaged(int? value) {
    mySmokingHabits = value;
  }

  partnerPrefferedDrinkingHabitsOnChaged(int? value) {
    partnerPrefferedDrinkingHabits = value;
  }

  partnerPrefferedSmokingHabitsOnChaged(int? value) {
    partnerPrefferedSmokingHabits = value;
  }

  Future<AccountModel> fetchMyProfile() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Approved_Profiles')
          .doc(userId)
          .get();
      final data = snapshot.data() as Map<String, dynamic>;
      final accountModel = AccountModel.fromJson(data);

      name.text = accountModel.name;
      phoneNumber = accountModel.phoneNumber;
      fullname.text = accountModel.fullName;
      skinColor.value = accountModel.skinColor;
      birthday.text = accountModel.birthday.toString().split(" ")[0];
      myBirthday = accountModel.birthday;
      accountFor = accountModel.accountFor;
      myGender = accountModel.gender;
      description.text = accountModel.description;
      sameCasteSearching = accountModel.sameCasteSearch;
      myCaste = accountModel.myCaste;
      inch = accountModel.inch;
      ft = accountModel.ft;
      marraigeStatus = accountModel.myMarraige;
      prefMarraigeStatus = accountModel.prefMarraige;
      kids = accountModel.kids;
      district = accountModel.district;
      race = accountModel.race;
      preQualities = accountModel.qualities;
      religion = accountModel.religion;
      myEduLvel = accountModel.myEduLvel;
      prefEduLevl = accountModel.prefEduLevl;
      eduAchis = accountModel.eduAchi;
      eduPlcs = accountModel.eduPlcs;
      jopPos.text = accountModel.jobPos;
      worlPlc.text = accountModel.workPlc;
      myDrinkingHabits = accountModel.myDrinks;
      mySmokingHabits = accountModel.mySmokes;
      partnerPrefferedDrinkingHabits = accountModel.prefDrinks;
      partnerPrefferedSmokingHabits = accountModel.prefSmokes;
      promo = accountModel.promo;
      createdAt = accountModel.createdAt as Timestamp;
      return accountModel;
    }
    // on FirebaseException catch (e) {
    //   if (e.code == 'permission-denied') {
    //     Get.defaultDialog(
    //         title: "Wait for account approval, please😟!",
    //         content: isEnglish
    //             ? Text(
    //                 "approval".tr,
    //                 style: GoogleFonts.oswald(
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               )
    //             : Text(
    //                 "approval".tr,
    //                 style: GoogleFonts.gemunuLibre(
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //         titleStyle: GoogleFonts.oswald(color: Colors.red, fontSize: 18),
    //         actions: [
    //           CupertinoDialogAction(
    //             child: Text(
    //               "Okay",
    //               style: GoogleFonts.oswald(color: Colors.blue, fontSize: 20),
    //             ),
    //             onPressed: () => Get.back(),
    //           ),
    //         ]);
    //   }
    // rethrow;
    // }
    catch (e) {
      Get.snackbar(
        'Error getting your account',
        '$e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }

  Future<void> updateProfile() async {
    isLoading.value = true;
    if (name.text.isEmpty || description.text.isEmpty) {
      isLoading.value = false;
      Get.snackbar(
        'Error updating account',
        'Please fill all the fields',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      List<String> images =
          await imagePickerController.uploadAllImagesToFirebase();
      final account = AccountModel(
        fullName: fullname.text,
        phoneNumber: phoneNumber!,
        userId: userId,
        skinColor: skinColor.value,
        imageUrls: images.isEmpty ? [] : images,
        name: name.text,
        birthday: myBirthday!,
        accountFor: accountFor!,
        gender: myGender!,
        description: description.text,
        sameCasteSearch: sameCasteSearching!,
        myCaste: myCaste!,
        inch: inch!,
        ft: ft!,
        myMarraige: marraigeStatus!,
        prefMarraige: prefMarraigeStatus!,
        kids: kids!,
        qualities: preQualities!,
        myEduLvel: myEduLvel!,
        prefEduLevl: prefEduLevl!,
        district: district!,
        race: race!,
        religion: religion!,
        jobPos: jopPos.text,
        workPlc: worlPlc.text,
        eduAchi: eduAchis.isEmpty ? [] : eduAchis,
        eduPlcs: eduPlcs.isEmpty ? [] : eduPlcs,
        myDrinks: myDrinkingHabits!,
        mySmokes: mySmokingHabits!,
        prefDrinks: partnerPrefferedDrinkingHabits!,
        prefSmokes: partnerPrefferedSmokingHabits!,
        promo: promo!,
        createdAt: createdAt! as Timestamp,
      );

      await FirebaseFirestore.instance
          .collection('Approved_Profiles')
          .doc(userId)
          .set(
            account.toJson(),
          );
      isLoading.value = false;
      Get.snackbar(
        'Account updated',
        'Your account has been updated successfully',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error getting your account',
        '$e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      rethrow;
    }
  }
}

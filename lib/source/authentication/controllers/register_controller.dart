import 'dart:ui';

import 'package:app/source/authentication/controllers/authentication_repository.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class RegisterController extends GetxController {
  RxBool passwordShow = false.obs;
  RxBool repeatPasswordShow = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeatPassword = TextEditingController();
  late TutorialCoachMark tutorial;
  late bool isEnglish;

  final GlobalKey emailKey = GlobalKey();
  final GlobalKey passwordKey = GlobalKey();

  @override
  void onReady() {
    createTutorial();
    isEnglish = LocalDbManager.getData('1') == 2 ? true : false;
    super.onReady();
  }

  passwordOnTap() {
    passwordShow.value = !passwordShow.value;
  }

  repeatPasswordOnTap() {
    repeatPasswordShow.value = !repeatPasswordShow.value;
  }

  load() {
    isLoading.value = true;
  }

  stopLoad() {
    isLoading.value = false;
  }

  Future<void> register() async {
    load();
    if (validateEmailAndPassword()) {
      Get.put(AuthenticationRepository());
      try {
        //Register user
        await AuthenticationRepository.instance
            .registerUser(email.text, password.text);
        stopLoad();
      } catch (e) {
        Get.snackbar(
          'Error while creating account🤥',
          '$e',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        stopLoad();
      }
    } else {
      stopLoad();
    }
  }

  bool validateEmailAndPassword() {
    // Email validation using a simple regex
    final emailValid = GetUtils.isEmail(email.text);

    // Password length check
    final passwordValid = password.text.length >= 6;

    final isEmpty = email.text.isEmpty || password.text.isEmpty;

    if (isEmpty) {
      Get.snackbar(
        'Fields are empty😣',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      );
      return false;
    }

    if (!emailValid) {
      Get.snackbar('Invalid Email😣',
          'Please enter a valid email address \n වලංගු email ලිපිනයක් ඇතුළු කරන්න',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return false;
    }

    if (!passwordValid) {
      Get.snackbar('Password Too Short😣',
          'Password must be at least 6 characters long \n මුරපදය අවම වශයෙන් අක්ෂර 6 ක් දිග විය යුතුය',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5));
      return false;
    }

    return emailValid && passwordValid;
  }

  Future<void> createTutorial() async {
    final targets = [
      TargetFocus(
        identify: 'emailfield',
        keyTarget: emailKey,
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
                  'regEmailTut'.tr,
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
        identify: 'passwordfield',
        keyTarget: passwordKey,
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
                  'regPswTut'.tr,
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
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
    );

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   tutorial.show(context: context);
    // });
  }
}

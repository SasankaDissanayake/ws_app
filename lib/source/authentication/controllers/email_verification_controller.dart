import 'package:app/source/authentication/controllers/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerifyController extends GetxController {
  RxBool sent = false.obs;

  Future<void> sendEmail() async {
    Get.put(AuthenticationRepository());
    try {
      //Register user
      await AuthenticationRepository.instance.sendEmailVerification();
      sent.value = true;
    } catch (e) {
      Get.snackbar(
        'Error sending verification email🤥',
        '$e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      ); // Add this print statement for error handling
      // Display an error message to the user
    }
  }

  checkStatus() {
    Get.put(AuthenticationRepository());
    FirebaseAuth.instance.currentUser?.reload();
  }

  noMyAcccout() {
    Get.put(AuthenticationRepository());
    AuthenticationRepository.instance.signOut();
  }
}

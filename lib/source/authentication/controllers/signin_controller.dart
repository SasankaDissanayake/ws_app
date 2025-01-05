import 'package:app/source/authentication/controllers/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  RxBool passwordShow = false.obs;
  RxBool isLoading = false.obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  passwordOnTap() {
    passwordShow.value = !passwordShow.value;
  }

  load() {
    isLoading.value = true;
  }

  stopLoad() {
    isLoading.value = false;
  }

  Future<void> signIn() async {
    load();
    if (validateEmailAndPassword()) {
      //Sign in
      Get.put(AuthenticationRepository());

      try {
        await AuthenticationRepository.instance
            .signInUser(email.text, password.text);
        stopLoad();
      } catch (e) {
        Get.snackbar(
          'Error while signin🤥',
          '$e',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        ); //
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
      );
      return false;
    }

    if (!emailValid) {
      Get.snackbar(
        'Invalid Email😣',
        'Please enter a valid email address \n වලංගු email ලිපිනයක් ඇතුළු කරන්න',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }

    if (!passwordValid) {
      Get.snackbar(
        'Password Too Short😣',
        'Password must be at least 6 characters long \n මුරපදය අවම වශයෙන් අක්ෂර 6 ක් දිග විය යුතුය',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }

    return emailValid && passwordValid;
  }
}

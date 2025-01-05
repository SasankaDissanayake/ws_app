// import 'package:app/source/authentication/screens/email_verification_screen.dart';
import 'package:app/source/authentication/screens/signin_or_register_screen_widget.dart';
import 'package:app/source/home/screens/home_screen_widget.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:app/source/splash_screen/screens/splash_screen_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> user;

  @override
  void onReady() {
    user = Rx<User?>(_auth.currentUser);
    user.bindStream(_auth.userChanges());
    int? lang = LocalDbManager.getData('1');

    if (lang != null) {
      if (lang == 1) {
        Get.updateLocale(const Locale('si', 'LK'));
      } else {
        Get.updateLocale(const Locale('en', 'US'));
      }
    }

    ever(user, _handleUser);
    super.onReady();
  }

  // _handleUser(User? user) {
  //   user == null
  //       ? Get.offAll(SplashScreen(stateId: 0))
  //       : user.emailVerified
  //           ? Get.offAll(SplashScreen(stateId: 1))
  //           : Get.offAll(EmailVerification());
  // }
  _handleUser(User? user) {
    user == null
        ? Get.offAll(SplashScreen(stateId: 0))
        : Get.offAll(SplashScreen(stateId: 1));
  }

  Future<void> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user.value != null
          ? Get.offAll(Home())
          : Get.offAll(const SigninOrRegister());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error creating account😑', e.message!,
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    } catch (_) {
      Get.snackbar('error😑', _.toString());
    }
  }

  Future<void> signInUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      user.value != null
          ? Get.offAll(Home())
          : Get.offAll(const SigninOrRegister());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error while signin😑',
        e.message!,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (_) {
      Get.snackbar('error😑', _.toString());
    }
  }

  Future<void> signOut() async => await _auth.signOut();

  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error sending email verification😑',
        e.message!,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } catch (_) {
      Get.snackbar('error😑', _.toString());
    }
  }
}

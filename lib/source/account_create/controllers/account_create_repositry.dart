import 'package:app/source/references/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccontCreateRepositoy extends GetxController {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> uploadUserProfile(AccountModel userProfile) async {
    try {
      await _db
          .collection('Profiles')
          .doc(userProfile.userId)
          .set(userProfile.toJson());

      return true;
    } catch (e) {
      Get.snackbar(
        'Error uploading user profile',
        '$e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }
}

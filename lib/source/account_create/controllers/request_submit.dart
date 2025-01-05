import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestSubmitController extends GetxController {
  Future<void> makeRequest(
    String name,
    String phoneNumber,
    String promoCode,
    int requestType,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final requestData = {
      'name': name,
      'phoneNumber': phoneNumber,
      'promoCode': promoCode,
      'requestType': requestType,
    };
    try {
      await FirebaseFirestore.instance
          .collection('Client_Requests')
          .doc(userId)
          .collection('acc_crea')
          .doc(userId)
          .set(requestData);
    } catch (e) {
      Get.snackbar(
        'Error while creating account🤥',
        '$e \nTry again please!',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }
}

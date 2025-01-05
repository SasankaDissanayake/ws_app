import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestSendController extends GetxController {
  final TextEditingController message = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> sendInvitation(String otherUid) async {
    isLoading.value = true;

    if (message.text.isNotEmpty) {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      RequestSendModel request = RequestSendModel(
        userId,
        otherUid,
        message.text,
        Timestamp.fromDate(DateTime.now()),
        null,
      );

      String docId = "$userId to $otherUid";
      try {
        await FirebaseFirestore.instance
            .collection("Requests")
            .doc(docId)
            .set(request.toJson());

        Get.back(result: true);
        message.clear();
        Get.snackbar(
          'Done🥳',
          'Invitation sent successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      } catch (e) {
        isLoading.value = false;
      }
      isLoading.value = false;
    } else {
      Get.snackbar(
        'Send a message with the invitation',
        'It would make the chance of getting reply back higher',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      isLoading.value = false;
    }
  }
}

import 'dart:math';
import 'package:app/source/chat/controllers/chat_room_creator.dart';
import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncommingTitleController extends GetxController {
  String myUid = FirebaseAuth.instance.currentUser!.uid;
  final ChatRoomCreator creator = Get.put(ChatRoomCreator());

  Future<ExploreProfileModel> getProfile(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(userId)
        .get();

    final profile = ExploreProfileModel.fromJson(snapshot.data()!);
    profile.backgroundImage = getBackgroundImage();
    return profile;
  }

  Future<void> rejectRequest(RequestSendModel request) async {
    String docId = "${request.senderUserId} to $myUid";

    await FirebaseFirestore.instance
        .collection("Requests")
        .doc(docId)
        .update({'requestStatus': 'declined'});

    Get.snackbar(
      'Done',
      'Request denied',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
    );
  }

  Future<void> acceptRequest(
    RequestSendModel request,
    ExploreProfileModel profile,
  ) async {
    String docId = "${request.senderUserId} to $myUid";
    await creator.createChatRoom(request, profile).then((value) async {
      if (value) {
        await FirebaseFirestore.instance
            .collection("Requests")
            .doc(docId)
            .update({'requestStatus': 'accepted'});

        Get.snackbar(
          'Done🥳',
          'Please check the chat page',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      } else {
        Get.snackbar(
          'Something went wrong',
          'Try again or contact support',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
        );
      }
    });
  }

  getBackgroundImage() {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    final random = Random();

    return AssetImage(
      isDark
          ? backgroundsDark[random.nextInt(backgroundsDark.length)]
          : backgroundsLight[random.nextInt(backgroundsLight.length)],
    );
  }
}

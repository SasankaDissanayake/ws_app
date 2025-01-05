import 'dart:math';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutgoingTileController extends GetxController {
  Future<ExploreProfileModel> getProfile(String userId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(userId)
        .get();

    final profile = ExploreProfileModel.fromJson(snapshot.data()!);
    profile.backgroundImage = getBackgroundImage();
    return profile;
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

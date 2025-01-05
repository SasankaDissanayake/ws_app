import 'package:app/source/chat/screens/chat_screen_widget.dart';
import 'package:app/source/explore/screens/explore_screen_widget.dart';
import 'package:app/source/my_profile/screens/my_profile_screen_widget.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:app/source/splash_screen/screens/loading_screen_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeNavigationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rx<int> selectedIndex = 0.obs;

  List<Widget> screens = [
    Explore(),
    Chats(),
    const LoadingScreen(),
  ];

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void onDestinationSelected(int index) {
    if (index == 2) {
      screens[2] = MyProfile();
    }
    selectedIndex.value = index;

    if (index != 2) {
      screens[2] = const LoadingScreen();
    }
  }

  Future<bool> getMyProfile() async {
    final userId = getCurrentUser()?.uid;

    final cachedTime = LocalDbManager.getData('profile_check_time_$userId');
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final weekAgo = currentTime - (const Duration(days: 7).inMilliseconds);

    if (cachedTime != null && cachedTime > weekAgo) {
      return true;
    }
    final snapShot = await _db.collection('Profiles').doc(userId).get();

    if (snapShot.exists) {
      final profileData = snapShot.data() as Map<String, dynamic>;
      final name = profileData['name'] as String?;

      await LocalDbManager.saveData('gender', profileData['gender']);

      if (name != null && name.isNotEmpty) {
        LocalDbManager.saveData('profile_check_time_$userId', currentTime);
        return true;
      }
    }

    return false;
  }
}

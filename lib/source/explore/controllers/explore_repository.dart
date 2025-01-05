import 'dart:math';
import 'package:app/source/chat_request/screens/message_typing_screen_widget.dart';
import 'package:app/source/explore/components/profile_card.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';

class ExploreRepository extends GetxController {
  static ExploreRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CardSwiperController cardSwiperController = CardSwiperController();

  final int fetchSize = 4;
  int nowCurrentIndex = 0;
  RxList<ProfileCard> profiles = <ProfileCard>[].obs;
  RxBool isLoading = false.obs;
  RxBool isEndOfCollection = false.obs;
  late User user;
  late AccountModel myProfile;
  DocumentSnapshot? lastDocumentLocal;
  AccountModel? lastDocumentCloud;
  bool isLastDocumentFromCloudLoaded = false;

  RxBool hasError = false.obs;
  FirebaseException? error;

  @override
  void onInit() async {
    load();
    update();
    getCurrentUser();
    await getMyProfile();
    super.onInit();
  }

  @override
  void onReady() async {
    load();
    update();
    await getLastDocumnent().then(
      (value) async => await fetchProfiles(),
    );
    update();
    super.onReady();
  }

  getCurrentUser() {
    user = _auth.currentUser!;
  }

  Future<void> getMyProfile() async {
    try {
      final snapShot =
          await _db.collection('Approved_Profiles').doc(user.uid).get();
      myProfile = AccountModel.fromJson(snapShot.data()!);
    } on FirebaseException catch (e) {
      hasError.value = true;
      error = e;
      stopLoad();
      update();
    }
  }

  Future<void> fetchProfiles() async {
    try {
      int oppositeGender = myProfile.gender == 0 ? 1 : 0;

      Query query = _db
          .collection('Approved_Profiles')
          .where('gender', isEqualTo: oppositeGender)
          .orderBy('createdAt', descending: false)
          .limit(fetchSize);

      if (isLastDocumentFromCloudLoaded) {
        query = query.startAfter([lastDocumentCloud!.createdAt]);
        isLastDocumentFromCloudLoaded = false;
      } else if (lastDocumentLocal != null) {
        query = query.startAfterDocument(lastDocumentLocal!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocumentLocal = querySnapshot.docs.last;

        final newProfiles = querySnapshot.docs
            .map((doc) {
              final data = doc.data();
              final profile =
                  ExploreProfileModel.fromJson(data as Map<String, dynamic>);
              profile.backgroundImage = getBackgroundImage();
              profile.documentSnapshot = doc;
              final profileCard = ProfileCard(profile: profile);
              return profileCard;
            })
            .whereType<ProfileCard>()
            .toList();

        profiles.addAll(newProfiles);
        stopLoad();
        hasError.value = false;

        update();
      } else {
        isEndOfCollection.value = true;
        stopLoad();
        hasError.value = false;
        // update();
      }
    } on FirebaseException catch (e) {
      hasError.value = true;
      error = e;
      stopLoad();
      update();
    }
  }

  Future<void> saveLastDocument(DocumentSnapshot last) async {
    final lastData = last.data();
    final lastDocument = {'lastDocument': lastData};
    await _db.collection("Users").doc(user.uid).set(lastDocument);
  }

  Future<void> getLastDocumnent() async {
    final snapShot = await _db.collection('Users').doc(user.uid).get();

    if (snapShot.exists) {
      final profileData = snapShot.data() as Map<String, dynamic>;

      if (profileData.containsKey('lastDocument')) {
        final doc = profileData['lastDocument'];

        if (doc != null) {
          lastDocumentCloud = AccountModel.fromJson(doc);
          isLastDocumentFromCloudLoaded = true;
          lastDocumentLocal = null;
        } else {
          lastDocumentCloud = null;
        }
      } else {
        lastDocumentCloud = null;
      }
    }
  }

  Future<bool> onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    nowCurrentIndex = previousIndex;

    final lastProfile = profiles[previousIndex];

    if (direction.name == 'left') {
      saveLastDocument(lastProfile.profile.documentSnapshot!);
    }

    if (direction.name == 'right') {
      //Implement chat request
      final done = await Get.to(
        MessageTyping(profile: lastProfile.profile),
        transition: Transition.downToUp,
        duration: const Duration(seconds: 1),
      );
      if (done) {
        saveLastDocument(lastProfile.profile.documentSnapshot!);
      }
    }

    if (previousIndex % 2 == 0) {
      fetchProfiles();
    }
    return true;
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

  load() {
    isLoading.value = true;
  }

  stopLoad() {
    isLoading.value = false;
  }

  void collectionOver() {
    if (isEndOfCollection.value) {
      update();
    }
  }

  @override
  void dispose() {
    cardSwiperController.dispose();
    super.dispose();
  }
}

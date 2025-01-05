import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImageServiceController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final RxList<dynamic> images = <dynamic>[].obs;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  // Function to fetch images from Firebase and populate the list
  Future<void> fetchImagesFromFirebase() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Profiles')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final imageUrls = List<String>.from(data['imageUrls'] ?? []);

        for (int i = 0; i < imageUrls.length && i < images.length; i++) {
          images[i] = imageUrls[i];
        }
        while (images.length < 6) {
          images.add(null);
        }

        while (images.length < 6) {
          images.add(null);
        }
      }
    } catch (e) {
      Get.snackbar('Error creating account', e.toString(),
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await picker.pickMultiImage(
      imageQuality: 80,
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (pickedFiles != null) {
      for (final pickedFile in pickedFiles) {
        final firstNullIndex = images.indexWhere((image) => image == null);
        if (firstNullIndex != -1) {
          images[firstNullIndex] = File(pickedFile.path);
        } else if (images.length < 6) {
          images.add(File(pickedFile.path));
        } else {
          break;
        }
      }
    }
  }

  // Function to upload all images (new and existing) to Firebase
  Future<List<String>> uploadAllImagesToFirebase() async {
    List<String> downloadUrls = [];

    for (var i = 0; i < images.length; i++) {
      if (images[i] is File) {
        final file = images[i] as File;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/$userId/${Uuid().v4()}');

        final uploadTask = storageRef.putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      } else if (images[i] is String) {
        downloadUrls.add(images[i]);
      }
    }

    await FirebaseFirestore.instance
        .collection('Profiles')
        .doc(userId)
        .update({'imageUrls': downloadUrls});

    return downloadUrls;
  }
}

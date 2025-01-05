import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImagePickerController extends GetxController {
  final ImagePicker picker = ImagePicker();
  final RxList<File?> images = <File?>[null, null, null, null, null, null].obs;

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
          // If there's a null placeholder
          images[firstNullIndex] = File(pickedFile.path);
        } else if (images.length < 6) {
          // If no placeholder but still space
          images.add(File(pickedFile.path));
        } else {
          break; // Stop adding if the limit is reached
        }
      }
    }
  }

  Future<List<String>> uploadImagesToFirebase() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    List<String> downloadUrls = [];

    for (var i = 0; i < images.length; i++) {
      if (images[i] != null) {
        final file = images[i]!;
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images/$userId/${Uuid().v4()}'); // Unique filename

        final uploadTask = storageRef.putFile(file);
        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      }
    }
    return downloadUrls;
  }
}

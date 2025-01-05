import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RequestCheck extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> checkRequest() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final snapShot = await _db
        .collection('Client_Requests')
        .doc(userId)
        .collection('acc_crea')
        .doc(userId)
        .get();

    if (snapShot.exists) {
      final profileData = snapShot.data() as Map<String, dynamic>;
      final type = profileData['requestType'] as int;
      if (type == 1) {
        return true;
      }
    }
    return false;
  }
}

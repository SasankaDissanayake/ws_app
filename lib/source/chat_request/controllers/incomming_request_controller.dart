import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class IncommingRequestController extends GetxController {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<List<RequestSendModel>> getMyIncommingRequests() async {
    final query = FirebaseFirestore.instance
        .collection("Requests")
        .where('reciverUserId', isEqualTo: userId)
        .where('requestStatus', isNull: true)
        .orderBy('createdAt', descending: false);

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => RequestSendModel.fromJson(doc.data()))
        .toList();
  }
}

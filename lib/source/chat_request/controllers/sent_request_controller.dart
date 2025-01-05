import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OutgoingRequestController extends GetxController {
  Future<List<RequestSendModel>> getMyPendingRequests() async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    final query = FirebaseFirestore.instance
        .collection("Requests")
        .where('senderUserId', isEqualTo: userId)
        .where('requestStatus', isNull: true)
        .orderBy('createdAt', descending: true);

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => RequestSendModel.fromJson(doc.data()))
        .toList();
  }
}

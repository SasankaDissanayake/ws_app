import 'package:app/source/chat/controllers/last_msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LastMessageController extends GetxController {
  String myUid = FirebaseAuth.instance.currentUser!.uid;

  Stream<LastMsgModel> getLastMessageStream(String chatRoomId) {
    return FirebaseFirestore.instance
        .collection('ChatRooms')
        .doc(chatRoomId)
        .snapshots()
        .map((snapshot) {
      final doc = snapshot.data()!;
      return LastMsgModel.fromJson(doc);
    });
  }
}

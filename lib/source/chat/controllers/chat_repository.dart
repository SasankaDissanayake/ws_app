import 'package:app/source/chat/controllers/chat_tile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();

  String myUid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<String>> getMyChatRooms() async {
    final snapshot =
        await _db.collection('Users').doc(myUid).collection('Chat').get();
    final data =
        snapshot.docs.map((doc) => doc.data()['chatRoomId'] as String).toList();
    return data;
  }

  Stream<List<ChatTileModel>> chatDataStream() async* {
    try {
      final chatRoomIds = await getMyChatRooms();
      final snapshot = _db
          .collection('ChatRooms')
          .where('chatRoomId', whereIn: chatRoomIds)
          .orderBy('sendTime', descending: true)
          .snapshots();

      yield* snapshot.map((snapshot) => snapshot.docs
          .map((doc) => ChatTileModel.fromJson(doc.data(), myUid))
          .toList());
    } catch (e) {
      print("Error\n${e.toString()}");
    }
  }
}

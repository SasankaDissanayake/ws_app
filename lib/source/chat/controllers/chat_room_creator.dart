import 'package:app/source/chat/controllers/chat_room_create_model.dart';
import 'package:app/source/chat/controllers/last_msg_model.dart';
import 'package:app/source/chat/controllers/message_model.dart';
import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatRoomCreator extends GetxController {
  String myUid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> createChatRoom(
    RequestSendModel request,
    ExploreProfileModel profile,
  ) async {
    try {
      List<String> ids = [myUid, request.senderUserId];
      ids.sort();
      String chatRoomId = ids.join('_');

      final myProfileSnapshot =
          await _db.collection('Profiles').doc(myUid).get();

      final myAccount = ExploreProfileModel.fromJson(
          myProfileSnapshot.data() as Map<String, dynamic>);

      ChatRoomCreateModel chatRoom = ChatRoomCreateModel(
        chatRoomId: chatRoomId,
        user1Uid: request.senderUserId,
        user2Uid: myUid,
        user1Name: profile.name,
        user2Name: myAccount.name,
      );

      await _db
          .collection('Users')
          .doc(myUid)
          .collection('Chat')
          .add(chatRoom.toJson());
      await _db
          .collection('Users')
          .doc(request.senderUserId)
          .collection('Chat')
          .add(chatRoom.toJson());

      MessageModel msg = MessageModel(
        senderId: request.senderUserId,
        receiverId: request.reciverUserId,
        message: request.message,
        timestamp: Timestamp.fromDate(DateTime.now()),
        readRecipt: false,
      );

      await _db.collection("ChatRooms").doc(chatRoomId).set(chatRoom.toJson());

      await _db
          .collection("ChatRooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(msg.toJson());

      final lastMsg = LastMsgModel(
        sender: request.senderUserId,
        message: request.message,
        sendTime: msg.timestamp,
        isRead: false,
      );

      await _db
          .collection("ChatRooms")
          .doc(chatRoomId)
          .update(lastMsg.toJson());

      final profileImages = {
        "${request.senderUserId}image":
            myAccount.imageUrls.isNotEmpty ? myAccount.imageUrls[0] : null,
        "${myAccount.userId}image":
            profile.imageUrls.isNotEmpty ? profile.imageUrls[0] : null,
      };
      await _db.collection("ChatRooms").doc(chatRoomId).update(profileImages);

      return true;
    } catch (e) {
      Get.snackbar(
        'Oops... Something went wrong😞',
        "Error: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }
}

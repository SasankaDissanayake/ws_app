import 'package:app/source/chat/controllers/chat_tile_model.dart';
import 'package:app/source/chat/controllers/last_msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndividualChatController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  String myUid = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final ScrollController scrollController = ScrollController();

  Stream<QuerySnapshot> getMsgs(ChatTileModel info) {
    return _db
        .collection("ChatRooms")
        .doc(info.chatRoomId)
        .collection("messages")
        .orderBy("sendTime", descending: false)
        .snapshots();
  }

  Future<void> updateLastMessageReadRecipt(
      LastMsgModel msg, String chatRoomId) async {
    if (!(msg.sender == myUid)) {
      final updatable = {
        'readRecipt': true,
      };
      await _db.collection('ChatRooms').doc(chatRoomId).update(updatable);
      print("Updated ${msg.message}");
    }
  }

  Future<void> sendMsg(ChatTileModel chatTile, String message) async {
    final Timestamp timestamp = Timestamp.now();

    LastMsgModel newMessage = LastMsgModel(
      sender: myUid,
      message: message,
      sendTime: timestamp,
      isRead: false,
    );

    await _db
        .collection("ChatRooms")
        .doc(chatTile.chatRoomId)
        .collection("messages")
        .add(newMessage.toJson());

    await _db
        .collection("ChatRooms")
        .doc(chatTile.chatRoomId)
        .update(newMessage.toJson());
  }

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 1000),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }
}

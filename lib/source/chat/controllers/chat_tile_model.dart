import 'package:cloud_firestore/cloud_firestore.dart';

class ChatTileModel {
  final String chatRoomId;
  final String userName;
  final String? userImage;
  final String lastMsg;
  final bool readRecipt;
  final String sender;
  final Timestamp sentTime;

  ChatTileModel({
    required this.chatRoomId,
    required this.userName,
    required this.userImage,
    required this.lastMsg,
    required this.readRecipt,
    required this.sender,
    required this.sentTime,
  });

  factory ChatTileModel.fromJson(Map<String, dynamic> json, String myUserId) =>
      ChatTileModel(
        chatRoomId: json['chatRoomId'] as String,
        userName: json[myUserId] as String,
        userImage: json['${myUserId}image'] as String?,
        lastMsg: json['message'] as String,
        readRecipt: json['readRecipt'] as bool,
        sender: json['senderId'] as String,
        sentTime: json['sendTime'] as Timestamp,
      );
}

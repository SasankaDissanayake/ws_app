import 'package:cloud_firestore/cloud_firestore.dart';

class LastMsgModel {
  final String sender;
  final String message;
  final Timestamp sendTime;
  bool isRead;

  LastMsgModel({
    required this.sender,
    required this.message,
    required this.sendTime,
    required this.isRead,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': sender,
      'message': message,
      'sendTime': sendTime,
      'readRecipt': isRead,
    };
  }

  factory LastMsgModel.fromJson(Map<String, dynamic> json) => LastMsgModel(
        sender: json['senderId'] as String,
        message: json['message'] as String,
        sendTime: json['sendTime'] as Timestamp,
        isRead: json['readRecipt'] as bool,
      );
}

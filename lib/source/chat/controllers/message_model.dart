import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp timestamp;
  bool readRecipt;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    required this.readRecipt,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'sendTime': timestamp,
      'readRecipt': readRecipt,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json['senderUserId'] as String,
        receiverId: json['reciverUserId'] as String,
        message: json['message'] as String,
        timestamp: json['readRecipt'] as Timestamp,
        readRecipt: json['readRecipt'] as bool,
      );
}

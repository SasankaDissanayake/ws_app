import 'package:cloud_firestore/cloud_firestore.dart';

class RequestSendModel {
  final String senderUserId;
  final String reciverUserId;
  final String message;
  final Timestamp createdAt;
  String? requestStatus;

  RequestSendModel(this.senderUserId, this.reciverUserId, this.message,
      this.createdAt, this.requestStatus);

  toJson() {
    return {
      'senderUserId': senderUserId,
      'reciverUserId': reciverUserId,
      'message': message,
      'requestStatus': requestStatus,
      'createdAt': createdAt,
    };
  }

  factory RequestSendModel.fromJson(Map<String, dynamic> json) =>
      RequestSendModel(
        json['senderUserId'] as String,
        json['reciverUserId'] as String,
        json['message'] as String,
        json['createdAt'] as Timestamp,
        json['requestStatus'] as String?,
      );
}

class ChatRoomCreateModel {
  final String chatRoomId;
  final String user1Uid;
  final String user2Uid;
  final String user1Name;
  final String user2Name;

  ChatRoomCreateModel({
    required this.chatRoomId,
    required this.user1Uid,
    required this.user2Uid,
    required this.user1Name,
    required this.user2Name,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      user1Uid: user2Name,
      user2Uid: user1Name,
    };
  }
}

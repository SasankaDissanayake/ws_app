import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Timestamp sentTime;

  const CustomChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.sentTime,
  });

  @override
  Widget build(BuildContext context) {
    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return ChatBubble(
      clipper: ChatBubbleClipper3(
          type: isCurrentUser
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble),
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      alignment: aligment,
      backGroundColor:
          isCurrentUser ? Colors.blue.shade600 : Colors.grey.shade100,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                message,
                style: isCurrentUser
                    ? const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
              ),
            ),
            Text(
              "\n${formatTimestamp(sentTime)}",
              style: isCurrentUser
                  ? GoogleFonts.oswald(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)
                  : GoogleFonts.oswald(
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontSize: 12,
                      fontWeight: FontWeight.w200),
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }

  String formatTimestamp(Timestamp timestamp) {
    final now = DateTime.now();
    final messageTime = timestamp.toDate();

    if (messageTime.year == now.year &&
        messageTime.month == now.month &&
        messageTime.day == now.day) {
      // If the message is from today, show the time
      return DateFormat('hh:mm a').format(messageTime);
    } else {
      // Otherwise, show the day and month
      return DateFormat('d MMM').format(messageTime);
    }
  }
}

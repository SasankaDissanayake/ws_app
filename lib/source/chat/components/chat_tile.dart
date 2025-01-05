import 'package:app/source/chat/controllers/chat_tile_model.dart';
import 'package:app/source/chat/controllers/last_message_controller.dart';
import 'package:app/source/chat/controllers/last_msg_model.dart';
import 'package:app/source/chat/screens/indiviual_chat_screen_widget.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatTile extends StatelessWidget {
  final ChatTileModel model;
  final LastMessageController lastMessageController =
      Get.put(LastMessageController());

  ChatTile({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    bool isMale = LocalDbManager.getData('gender') == 0 ? true : false;

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ListTile(
        leading: SizedBox(
          width: 60,
          height: 60,
          child: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: _image(context, model.userImage, isMale),
            ),
          ),
        ),
        title: Text(
          model.userName,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.white : Colors.black,
            fontSize: 20,
          ),
        ),
        subtitle: lastMsg(context),
        onTap: () {
          Get.to(IndiviualChat(
            info: model,
          ));
        },
      ),
    );
  }

  _image(BuildContext context, String? image, bool isMale) {
    return image != null
        ? Image.network(
            image,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                  backgroundColor: Colors.white,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          )
        : isMale
            ? Image.asset(malePlaceHolder)
            : Image.asset(femalePlaceHolder);
  }

  Widget lastMsg(BuildContext context) {
    return StreamBuilder<LastMsgModel?>(
      stream: lastMessageController.getLastMessageStream(model.chatRoomId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.yellow,
            backgroundColor: Colors.black,
          ));
        }

        final lastMsg = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            lastMsg!.sender == lastMessageController.myUid
                ? Icon(
                    Icons.done_all,
                    size: 25,
                    color: lastMsg.isRead ? Colors.green : Colors.grey,
                  )
                : Icon(
                    Icons.bubble_chart,
                    size: 25,
                    color: lastMsg.isRead ? Colors.grey : Colors.green,
                  ),
            const SizedBox(width: 5),
            Text(
              lastMsg.message,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        );
      },
    );
  }
}

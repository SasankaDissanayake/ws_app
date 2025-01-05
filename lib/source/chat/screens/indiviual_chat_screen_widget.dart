import 'package:app/source/chat/components/chat_bubble.dart';
import 'package:app/source/chat/controllers/chat_tile_model.dart';
import 'package:app/source/chat/controllers/individual_chat_controller.dart';
import 'package:app/source/chat/controllers/last_message_controller.dart';
import 'package:app/source/chat/controllers/last_msg_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IndiviualChat extends StatefulWidget {
  final ChatTileModel info;
  final IndividualChatController controller =
      Get.put(IndividualChatController());
  final LastMessageController lastMessageController =
      Get.put(LastMessageController());

  IndiviualChat({
    super.key,
    required this.info,
  });

  @override
  State<IndiviualChat> createState() => _IndiviualChatState();
}

class _IndiviualChatState extends State<IndiviualChat> {
  void sendMsg() async {
    if (widget.controller.textController.text.isNotEmpty) {
      await widget.controller
          .sendMsg(widget.info, widget.controller.textController.text);
      widget.controller.textController.clear();
    }
    widget.controller.scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      appBar: appBar(context, isDark),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: widget.controller.getMsgs(widget.info),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          if (snapshot.data!.docs.last.exists) {
            final lastMsgSnapshot = snapshot.data!.docs.last;
            final lastMsg = LastMsgModel.fromJson(
                lastMsgSnapshot.data() as Map<String, dynamic>);
            widget.controller
                .updateLastMessageReadRecipt(lastMsg, widget.info.chatRoomId);
          }
          return ListView(
            controller: widget.controller.scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageIteam(doc))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildMessageIteam(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderId'] == widget.controller.myUid;

    return CustomChatBubble(
      message: data['message'],
      isCurrentUser: isCurrentUser,
      sentTime: data['sendTime'],
    );
  }

  AppBar appBar(BuildContext context, bool isDark) {
    bool isMale = LocalDbManager.getData('gender') == 0 ? true : false;

    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
      centerTitle: false,
      titleSpacing: 0.0,
      title: Transform(
        transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _image(context, widget.info.userImage, isMale),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.info.userName,
            ),
          ],
        ),
      ),
      backgroundColor: isDark ? Colors.black : Colors.white,
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

  Widget lastMsg() {
    return StreamBuilder<LastMsgModel?>(
      stream: widget.lastMessageController
          .getLastMessageStream(widget.info.chatRoomId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.yellow,
              backgroundColor: Colors.black,
            ),
          );
        }

        final lastMsg = snapshot.data;
        return Icon(
          Icons.done_all,
          size: 25,
          color: lastMsg!.isRead ? Colors.green : Colors.grey,
        );
      },
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 8),
                child: lastMsg(),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.broken_image_outlined,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 0,
                  ),
                  child: TextField(
                    controller: widget.controller.textController,
                    maxLines: 4,
                    minLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Type your message here 🤩!",
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: sendMsg,
                icon: const Icon(
                  Icons.send,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Center(
        child: Lottie.asset(
          loadingAnimation,
          repeat: true,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(dynamic error) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    if (error is FirebaseException) {
      // final firebaseError = error as FirebaseException ;
      if (error.code == 'permission-denied') {
        WidgetsBinding.instance.addPostFrameCallback((_) => onError());
      }
    }

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              sorryAnimation,
              height: 150,
              repeat: true,
            ),
            const Text(
              "Oops! Something went wrong.",
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$error",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Oswald',
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  onError() {
    // bool isDark = Get.isDarkMode;
    // bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

    // Get.bottomSheet(
    //   Material(
    //     borderRadius: BorderRadius.circular(20),
    //     color: isDark ? Colors.black : Colors.white,
    //     child: Padding(
    //       padding: const EdgeInsets.only(left: 15, right: 15),
    //       child: ListView(
    //         shrinkWrap: true,
    //         children: [
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           isEnglish
    //               ? Text(
    //                   "premBottomSheet".tr,
    //                   style: GoogleFonts.oswald(
    //                     fontSize: 22,
    //                     color: isDark ? Colors.white : Colors.black,
    //                   ),
    //                   textAlign: TextAlign.center,
    //                 )
    //               : Text(
    //                   "premBottomSheet".tr,
    //                   style: GoogleFonts.gemunuLibre(
    //                     fontSize: 24,
    //                     color: isDark ? Colors.white : Colors.black,
    //                   ),
    //                   textAlign: TextAlign.center,
    //                 ),
    //           RichText(
    //             textAlign: TextAlign.center,
    //             text: TextSpan(
    //               text: '\n',
    //               style: GoogleFonts.gemunuLibre(
    //                 fontSize: 20,
    //               ),
    //               children: <TextSpan>[
    //                 TextSpan(
    //                   text: "\nLifetime membership\n",
    //                   style: GoogleFonts.oswald(
    //                     fontSize: 20,
    //                     color: isDark ? Colors.white : Colors.black,
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: 'Rs.1299.00\n',
    //                   style: GoogleFonts.oswald(
    //                     fontSize: 30,
    //                     decoration: TextDecoration.lineThrough,
    //                     fontWeight: FontWeight.w500,
    //                     color: Colors.red,
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: "61.55% disscount🥳",
    //                   style: GoogleFonts.oswald(
    //                     fontSize: 23,
    //                     color: isDark ? Colors.white : Colors.black,
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: "\n\nOnly\n",
    //                   style: GoogleFonts.oswald(
    //                     fontSize: 28,
    //                     fontWeight: FontWeight.w500,
    //                     color: Colors.green,
    //                   ),
    //                 ),
    //                 TextSpan(
    //                   text: "Rs.499.00/-",
    //                   style: GoogleFonts.oswald(
    //                     fontSize: 35,
    //                     fontWeight: FontWeight.w500,
    //                     color: Colors.green,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 30,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(left: 40, right: 40),
    //             child: ElevatedButton(
    //               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
    //               onPressed: () => Get.to(Pay()), //=> Get.to(Deposite()),
    //               child: Text(
    //                 "Pay",
    //                 style: GoogleFonts.oswald(
    //                   fontSize: 20,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(
    //             height: 40,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}

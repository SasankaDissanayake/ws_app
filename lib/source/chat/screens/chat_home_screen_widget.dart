import 'package:app/source/chat/components/chat_tile.dart';
import 'package:app/source/chat/controllers/chat_repository.dart';
import 'package:app/source/chat/controllers/chat_tile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ChatHome extends StatelessWidget {
  const ChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatRepository());
    return StreamBuilder<List<ChatTileModel>>(
        stream: ChatRepository.instance.chatDataStream(),
        builder: (context, chatSnapshot) {
          if (chatSnapshot.data == null) {
            return Container();
          }
          if (chatSnapshot.hasError) {
            return _buildErrorWidget(chatSnapshot.error);
          }
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingWidget(context);
          }

          final chatRooms = chatSnapshot.data!;

          return ListView.builder(
            itemCount: chatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = chatRooms[index];
              return ChatTile(model: chatRoom);
            },
          );
        });
  }

  Widget _buildLoadingWidget(BuildContext context) {
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

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              errorAnimation,
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
}

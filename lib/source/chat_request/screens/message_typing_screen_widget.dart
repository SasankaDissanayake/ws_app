import 'package:app/source/chat_request/controllers/request_send_controller.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageTyping extends StatelessWidget {
  final RequestSendController controller = Get.put(RequestSendController());
  final ExploreProfileModel profile;

  MessageTyping({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    // bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Send a invitation to ${profile.name}🥰",
                style: GoogleFonts.roboto(
                  color: isDark ? Colors.white : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: Get.height / 3,
                  child: profile.imageUrls.isNotEmpty
                      ? Image.network(profile.imageUrls[0],
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
                        })
                      : Image.asset(
                          profile.gender == 0
                              ? malePlaceHolder
                              : femalePlaceHolder,
                        ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: controller.message,
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide(width: 2)),
                  hintText: 'Type your message here🤩!',
                ),
              ),
            ),
            Obx(
              () => ElevatedButton(
                onPressed: () async {
                  await controller.sendInvitation(profile.userId);
                },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        color: Colors.green,
                      )
                    : const Text(
                        "Send",
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

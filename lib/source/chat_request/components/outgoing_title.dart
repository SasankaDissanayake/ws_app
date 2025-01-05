import 'package:app/source/chat_request/controllers/outgoing_tile_controller.dart';
import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:app/source/chat_request/screens/profile_card_widget_screen.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OutgoingRequestTile extends StatelessWidget {
  final RequestSendModel request;
  final OutgoingTileController controller = Get.put(OutgoingTileController());

  OutgoingRequestTile({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return FutureBuilder<ExploreProfileModel>(
      future: controller.getProfile(request.reciverUserId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final requests = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Container(
              decoration: BoxDecoration(
                  color: isDark
                      ? CupertinoColors.inactiveGray
                      : CupertinoColors.extraLightBackgroundGray,
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          height: Get.height / 3,
                          child: requests.imageUrls.isNotEmpty
                              ? Image.network(
                                  requests.imageUrls[0],
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.yellow,
                                        backgroundColor: Colors.white,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                )
                              : requests.gender == 0
                                  ? Image.asset(malePlaceHolder)
                                  : Image.asset(femalePlaceHolder),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: TextSpan(
                        text: 'Name: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                            text: "${requests.name}\n",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          const TextSpan(
                            text: '\nEducatinal Level: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: "${eduLevel[requests.myEduLvel]}\n",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          const TextSpan(
                            text: '\nMessage: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: request.message,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(ProfileCard(profile: requests));
                        },
                        child: const Text(
                          "View Profile",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        }
        // Show a loading indicator while waiting for data
        return _buildLoadingWidget(context);
      },
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
}

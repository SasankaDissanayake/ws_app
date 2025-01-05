import 'package:app/source/chat_request/controllers/incomming_title_controller.dart';
import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:app/source/chat_request/screens/profile_card_widget_screen.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class IncomingRequestTile extends StatelessWidget {
  final RequestSendModel request;
  final IncommingTitleController controller =
      Get.put(IncommingTitleController());

  IncomingRequestTile({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return FutureBuilder<ExploreProfileModel>(
        future: controller.getProfile(request.senderUserId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final profile = snapshot.data!;
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
                            child: profile.imageUrls.isNotEmpty
                                ? Image.network(
                                    profile.imageUrls[0],
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
                                : profile.gender == 0
                                    ? Image.asset(malePlaceHolder)
                                    : Image.asset(femalePlaceHolder),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          text: 'Name: ',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                            fontSize: 18,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "${profile.name}\n",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: '\nEducatinal Level: ',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: "${eduLevel[profile.myEduLvel]}\n",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: '\nMessage: ',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: request.message,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(ProfileCard(profile: profile));
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
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    acceptRequest(profile, isDark);
                                  },
                                  child: const Text(
                                    "Accept",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.dialog(
                                      CupertinoAlertDialog(
                                        title: const Text('Confirm'),
                                        content: const Text(
                                            'Do you really wanna reject the request?'),
                                        actions: <CupertinoDialogAction>[
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('No'),
                                          ),
                                          CupertinoDialogAction(
                                            isDestructiveAction: true,
                                            onPressed: () {
                                              controller.rejectRequest(request);
                                              Get.back();
                                            },
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Decline",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
        });
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

  void _showAlertDialog(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Confirm'),
        content: const Text('Do you really wanna reject the request?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              await controller.rejectRequest(request).then((value) {
                Get.back();
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> acceptRequest(ExploreProfileModel profile, bool isDark) async {
    Get.bottomSheet(
      Material(
        color: isDark ? Colors.black : Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Wait a second...",
              style: GoogleFonts.oswald(
                fontSize: 20,
                color: isDark ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              color: isDark ? Colors.black : Colors.white,
              child: Center(
                child: Lottie.asset(
                  loadingAnimation,
                  repeat: true,
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((value) async {
      await controller.acceptRequest(request, profile);
    });

    Get.back();
  }
}

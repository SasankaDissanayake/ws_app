import 'package:app/source/references/image_references.dart';
import 'package:app/source/splash_screen/controllers/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  final int stateId;

  SplashScreen({super.key, required this.stateId});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    SplashScreenController.find.startAnimation(stateId);

    final screenSize = Get.width;
    double oneSeventhOfScreenHeight = (Get.height / 7);
    double screenWidth = screenSize;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Obx(
            () => AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              top: splashController.animate.value
                  ? oneSeventhOfScreenHeight * 1.5
                  : oneSeventhOfScreenHeight,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: splashController.animate.value ? 1 : 0,
                child: Image(
                  image: const AssetImage(splashImage),
                  width: screenWidth,
                ),
              ),
            ),
          ),
          // Obx(
          //   () => AnimatedPositioned(
          //     duration: const Duration(milliseconds: 1000),
          //     bottom: splashController.animate.value ? 20 : -30,
          //     left: (screenWidth / 2 - logoImageWidth / 2),
          //     child: AnimatedOpacity(
          //       duration: const Duration(milliseconds: 1000),
          //       opacity: splashController.animate.value ? 1 : 0,
          //       child: Image(
          //         image: const AssetImage(logoImage),
          //         width: logoImageWidth,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

import 'package:app/source/account_create/controllers/account_create_repositry.dart';
import 'package:app/source/home/screens/home_screen_widget.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CreateProfile extends StatelessWidget {
  final AccontCreateRepositoy controller = Get.put(AccontCreateRepositoy());
  final AccountModel profile;
  CreateProfile({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: controller.uploadUserProfile(profile),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget(context);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offAll(Home());
            });
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else if (snapshot.hasData && !snapshot.data!) {
            return _buildErrorWidget('something went wrong please try again');
          } else {
            return Container();
          }
        }
        return Container(); // Default return
      },
    ));
  }

  Widget _buildErrorWidget(dynamic error) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              errorAnimation,
              height: 150,
              repeat: true,
            ),
            Text(
              "Oops! Something went wrong.",
              style: GoogleFonts.oswald(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$error",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(color: Colors.redAccent),
            ),
            IconButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Get.off(CreateProfile(profile: profile));
                  });
                },
                icon: const Icon(
                  Icons.replay_outlined,
                  size: 30,
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Try again",
              style: GoogleFonts.oswald(
                fontSize: 24,
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

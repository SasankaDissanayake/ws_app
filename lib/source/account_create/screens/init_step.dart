import 'package:app/source/account_create/controllers/request_check.dart';
import 'package:app/source/account_create/screens/first_step.dart';
import 'package:app/source/account_create/screens/redirect_page.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class InitStep extends StatelessWidget {
  final RequestCheck controller = Get.put(RequestCheck());
  InitStep({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.checkRequest(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget(context);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!) {
            return const Redirect();
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else if (!(snapshot.data!)) {
            //Create profile
            return FirstStep();
          } else {
            return _buildNoDataWidget();
          }
        }
        return _buildNoDataWidget(); // Default return
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

  Widget _buildNoDataWidget() {
    return Container(color: Colors.red);
  }
}

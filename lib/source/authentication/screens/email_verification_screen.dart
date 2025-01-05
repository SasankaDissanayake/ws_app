import 'package:app/source/authentication/controllers/email_verification_controller.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends StatelessWidget {
  EmailVerification({super.key});
  final EmailVerifyController controller = Get.put(EmailVerifyController());

  @override
  Widget build(BuildContext context) {
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

    final tenPx = Get.height / 89;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: tenPx * 3),
                  Text(
                    'Email Verification',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      fontSize: tenPx * 3,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.email,
                    size: tenPx * 7,
                  ),
                  SizedBox(height: tenPx * 3),
                  Padding(
                    padding: EdgeInsets.only(left: tenPx * 2, right: tenPx * 2),
                    child: Text(
                      'emailVerify'.tr,
                      style: TextStyle(
                        fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: tenPx * 4),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle continue button press
                      controller.checkStatus();
                    },
                    child: Text(
                      'I verified my email',
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: tenPx * 2,
                      ),
                    ),
                  ),
                  SizedBox(height: tenPx),
                  Obx(
                    () => !controller.sent.value
                        ? TextButton(
                            onPressed: () {
                              // Handle resend button press
                              controller.sendEmail();
                            },
                            child: Text(
                              'Send Email',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: tenPx * 2,
                              ),
                            ),
                          )
                        : Text(
                            'Email is on the way',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: tenPx * 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(height: tenPx),
                  TextButton(
                    onPressed: () {
                      controller.noMyAcccout();
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: tenPx * 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

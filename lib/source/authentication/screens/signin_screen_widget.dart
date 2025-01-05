import 'package:app/source/authentication/components/button.dart';
import 'package:app/source/authentication/components/email_field.dart';
import 'package:app/source/authentication/components/password_field.dart';
import 'package:app/source/authentication/controllers/signin_controller.dart';
import 'package:app/source/authentication/screens/register_screen_widget.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    bool isMale = LocalDbManager.getData('2') == 1 ? true : false;
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;
    final width = Get.width;
    final height = Get.height;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(child: Lottie.asset(imagePlaceholder)),
            Container(
              width: Get.width,
              height: Get.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  //Image choose according to theme and user's gender
                  image: AssetImage(isDark
                      ? isMale
                          ? authMaleDark
                          : authFemaleDark
                      : isMale
                          ? authMaleLight
                          : authFemaleLight),
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: width - 100,
                        height: height / 4,
                        child: const DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(titleImage),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Text(
                          'signSec'.tr,
                          style: TextStyle(
                            fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                            fontSize: 22,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      EmailField(
                        controller: controller.email,
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => PasswordField(
                            showPassword: controller.passwordShow.value,
                            controller: controller.password,
                            onTap: () {
                              controller.passwordOnTap();
                            }),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => ReusableButton(
                          onTap: () {
                            controller.isLoading.value == true
                                ? null
                                : controller.signIn();
                          },
                          text: 'S I G N  I N',
                          isLoading: controller.isLoading.value,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                          ),
                          Text(
                            'noAcc'.tr,
                            style: TextStyle(
                              fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                              fontSize: 18,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.off(Register());
                            },
                            child: Text(
                              "regNow".tr,
                              style: TextStyle(
                                fontFamily:
                                    isEnglish ? 'Oswald' : 'GemunuLibre',
                                color: isDark ? Colors.white : Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

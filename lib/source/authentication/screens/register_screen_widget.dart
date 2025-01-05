import 'package:app/source/authentication/components/button.dart';
import 'package:app/source/authentication/components/email_field.dart';
import 'package:app/source/authentication/components/password_field.dart';
import 'package:app/source/authentication/controllers/register_controller.dart';
import 'package:app/source/authentication/screens/signin_screen_widget.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final RegisterController controller = Get.put(RegisterController());

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
              child: Center(
                child: SafeArea(
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
                          'regSec'.tr,
                          style: TextStyle(
                            fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                            fontSize: 22,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      EmailField(
                        key: controller.emailKey,
                        controller: controller.email,
                        onTap: () {
                          controller.tutorial.show(context: context);
                        },
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => PasswordField(
                            key: controller.passwordKey,
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
                            controller.isLoading.value
                                ? null
                                : controller.register();
                          },
                          text: 'R E G I S T E R',
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
                            "alReg".tr,
                            style: TextStyle(
                              fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                              fontSize: 18,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.off(SignIn());
                            },
                            child: Text(
                              "sigNow".tr,
                              style: TextStyle(
                                fontFamily:
                                    isEnglish ? 'Oswald' : 'GemunuLibre',
                                fontSize: 18,
                                color: isDark ? Colors.white : Colors.black,
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

import 'package:app/source/initialization/components/gender_button.dart';
import 'package:app/source/initialization/controllers/init_gate_controller.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitScreen extends StatelessWidget {
  final InitController controller = Get.put(InitController());
  final int language;
  InitScreen({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnglish = language == 2 ? true : false;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    final tenPx = Get.height / 89;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Container(
        width: Get.size.width,
        height: Get.size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(isDark ? genImageDark : genImageLight),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: tenPx * 10),
              Text(
                'genTitle'.tr,
                style: TextStyle(
                  fontFamily: isEnglish ? 'Roboto' : 'GemunuLibre',
                  fontSize: tenPx * 4.5,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: tenPx * 4),
              Text(
                'genSecondry'.tr,
                style: TextStyle(
                  fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                  fontSize: tenPx * 3,
                  color: isDark ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: tenPx * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => GenScrnButtoon(
                      text: Text(
                        'male'.tr,
                        style: TextStyle(
                          fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                          fontSize: tenPx * 2.8,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      image: const AssetImage(male),
                      onTap: maleOnTap,
                      isSelected: controller.isMaleSelected.value,
                      tenPx: tenPx,
                    ),
                  ),
                  SizedBox(
                    width: tenPx * 2,
                  ),
                  Obx(() => GenScrnButtoon(
                        text: Text(
                          'female'.tr,
                          style: TextStyle(
                            fontFamily: isEnglish ? 'Oswald' : 'GemunuLibre',
                            fontSize: tenPx * 2.5,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        image: const AssetImage(female),
                        onTap: femaleOnTap,
                        isSelected: controller.isFemaleSelected.value,
                        tenPx: tenPx,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void maleOnTap() {
    controller.maleSelected();
  }

  void femaleOnTap() {
    controller.femaleSelected();
  }
}

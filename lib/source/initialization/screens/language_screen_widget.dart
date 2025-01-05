import 'package:app/source/initialization/components/language_button.dart';
import 'package:app/source/initialization/controllers/init_gate_controller.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangScreen extends StatelessWidget {
  final InitController controller = Get.put(InitController());

  LangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tenPx = Get.height / 89;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(langImage),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: tenPx * 13,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: tenPx,
                  ),
                  SizedBox(
                    height: tenPx * 10,
                    child: const Image(
                      image: AssetImage(langLankaImage),
                    ),
                  ),
                  Text(
                    "PLEASE\nCHOOSE YOUR\nLANGUAGE",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: tenPx * 3.5,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: tenPx * 2),
            Obx(
              () => LangScrnButtoon(
                onTap: sinhalaOnTap,
                text: Text(
                  'සි  o  හ  ල',
                  style: TextStyle(
                    fontFamily: 'GemunuLibre',
                    fontSize: tenPx * 2.5,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                image: const AssetImage(sinLang),
                isSelected: controller.isSinhalaSelected.value,
                tenPx: tenPx,
              ),
            ),
            SizedBox(height: tenPx * 2),
            Obx(
              () => LangScrnButtoon(
                onTap: tamilOnTap,
                text: Text(
                  'த மி ழ்',
                  style: TextStyle(
                    fontSize: tenPx * 2.5,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                image: const AssetImage(tamilLang),
                isSelected: controller.isTamilSelected.value,
                tenPx: tenPx,
              ),
            ),
            SizedBox(height: tenPx * 2),
            Obx(
              () => LangScrnButtoon(
                onTap: englishOnTap,
                text: Text(
                  'English',
                  style: TextStyle(
                    fontFamily: 'GemunuLibre',
                    fontSize: 25,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                image: const AssetImage(englishLang),
                isSelected: controller.isEnglishSelected.value,
                tenPx: tenPx,
              ),
            ),
          ],
        ),
      ),
    );
  }

  sinhalaOnTap() {
    controller.sinhalaSelected();
  }

  tamilOnTap() {
    controller.tamilSelected();
  }

  englishOnTap() {
    controller.englishSelected();
  }
}

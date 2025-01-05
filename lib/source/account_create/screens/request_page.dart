import 'package:app/source/account_create/controllers/request_submit.dart';
import 'package:app/source/account_create/screens/first_step_.dart';
import 'package:app/source/account_create/screens/redirect_page.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RequestPage extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String? promoCode;
  final RequestSubmitController controller = Get.put(RequestSubmitController());

  RequestPage({
    super.key,
    required this.name,
    required this.phoneNumber,
    this.promoCode,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 40,
            ),
            child: Column(
              children: [
                Text(
                  "Hello $name!",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                isEnglish
                    ? Text(
                        "reqPageTit".tr,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      )
                    : Text(
                        "reqPageTit".tr,
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                const SizedBox(height: 25),
                isEnglish
                    ? Text(
                        "reqPageSec".tr,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "reqPageSec".tr,
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () async {
                    await nextOnPreesed();
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    await reqOnPreesed();
                  },
                  child: Text(
                    'Make a request',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  reqOnPreesed() async {
    load();
    late String promo;
    if (promoCode != null) {
      promo = promoCode!;
    } else {
      promo = ' ';
    }
    int accReq = 1;
    await controller.makeRequest(name, phoneNumber, promo, accReq);
    Get.offAll(const Redirect());
  }

  nextOnPreesed() async {
    load();
    late String promo;
    if (promoCode != null) {
      promo = promoCode!;
    } else {
      promo = ' ';
    }
    int accReq = 2;
    await controller.makeRequest(name, phoneNumber, promo, accReq);
    Get.offAll(
      FirstStep1(
        name: name,
        phoneNumber: phoneNumber,
        promoCode: promo,
      ),
    );
  }

  load() {
    bool isDark = Get.isDarkMode;
    Get.bottomSheet(
      Material(
        color: isDark ? Colors.black : Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
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
    );
  }
}

import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key});

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isEnglish
                    ? Text(
                        "reqRed1".tr,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      )
                    : Text(
                        "reqRed1".tr,
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                isEnglish
                    ? Text(
                        "reqRed2".tr,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "reqRed2".tr,
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

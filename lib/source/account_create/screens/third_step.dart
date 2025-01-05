import 'package:app/source/account_create/controllers/account_create_controller1.dart';
import 'package:app/source/account_create/screens/forth_step.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ThirdStep extends StatelessWidget {
  final AccountCreateController1 controller =
      Get.put(AccountCreateController1());

  final String name;
  final String phoneNumber;
  final String fullName;
  final String promo;
  final DateTime birthday;
  final int accountFor;
  final int gender;
  final String description;
  final bool sameCasteSearch;
  final int myCaste;

  ThirdStep({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.fullName,
    required this.promo,
    required this.birthday,
    required this.accountFor,
    required this.gender,
    required this.description,
    required this.sameCasteSearch,
    required this.myCaste,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Tell us your height, Please?",
              style: GoogleFonts.openSans(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: GetBuilder<AccountCreateController1>(builder: (_) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final heightInFt = 3 + index;
                          return ListTile(
                            title: Text('$heightInFt Ft',
                                style: GoogleFonts.openSans(
                                    color: isDark ? Colors.white : Colors.black,
                                    fontWeight: FontWeight.bold)),
                            onTap: () {
                              controller.updateHeightFt(heightInFt);
                            },
                            selected: controller.selectedHeightFt == heightInFt,
                            selectedTileColor: Colors.grey[200],
                          );
                        },
                      );
                    }),
                  ),
                  Flexible(
                    child: GetBuilder<AccountCreateController1>(builder: (_) {
                      return ListView.builder(
                        itemCount: 11,
                        itemBuilder: (context, index) {
                          final heightInInch = 1 + index;
                          return ListTile(
                            title: Text('$heightInInch Inch',
                                style: GoogleFonts.openSans(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.bold,
                                )),
                            onTap: () {
                              controller.updateHeightInch(heightInInch);
                            },
                            selected:
                                controller.selectedHeightInch == heightInInch,
                            selectedTileColor: Colors.grey[200],
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            onPressed();
          },
          backgroundColor: isDark ? Colors.white : Colors.black,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: Colors.white,
          )),
    );
  }

  onPressed() {
    if (controller.selectedHeightFt != null &&
        controller.selectedHeightInch != null) {
      Get.off(ForthStep(
        name: name,
        phoneNumber: phoneNumber,
        fullName: fullName,
        promo: promo,
        birthday: birthday,
        accountFor: accountFor,
        gender: gender,
        description: description,
        sameCasteSearch: sameCasteSearch,
        myCaste: myCaste,
        inch: controller.selectedHeightInch!,
        ft: controller.selectedHeightFt!,
      ));
    } else {
      Get.snackbar(
        'Please choose your hight',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}

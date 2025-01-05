import 'package:app/source/account_create/components/drop_down_field.dart';
import 'package:app/source/account_create/controllers/account_create_controller2.dart';
import 'package:app/source/account_create/screens/seventh_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SixthStep extends StatelessWidget {
  final AccoutCreateController2 controller = Get.put(AccoutCreateController2());

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
  final int inch;
  final int ft;
  final int myMarraige;
  final int prefMarraige;
  final int kids;
  final List<String> qualities;

  SixthStep({
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
    required this.inch,
    required this.ft,
    required this.myMarraige,
    required this.prefMarraige,
    required this.kids,
    required this.qualities,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "So where do you live in?",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    "Your district",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownField(
                      dropDownList: districs, onChanged: districtOnChanged),
                  const SizedBox(height: 20),
                  Text(
                    "And what's your...?",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    "Race",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownField(dropDownList: race, onChanged: raceOnChanged),
                  const SizedBox(height: 20),
                  Text(
                    "Religion",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownField(
                      dropDownList: religion, onChanged: religionOnChanged),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: isDark ? Colors.white : Colors.black,
          shape: const CircleBorder(),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: isDark ? Colors.black : Colors.white,
          )),
    );
  }

  districtOnChanged(int? value) {
    controller.updateDistrict(value);
  }

  raceOnChanged(int? value) {
    controller.updateRace(value);
  }

  religionOnChanged(int? value) {
    controller.updateReligion(value);
  }

  onPressed() {
    if (controller.district != null &&
        controller.race != null &&
        controller.religion != null) {
      Get.off(
        SeventhStep(
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
          inch: inch,
          ft: ft,
          myMarraige: myMarraige,
          prefMarraige: prefMarraige,
          kids: kids,
          qualities: qualities,
          district: controller.district!,
          race: controller.race!,
          religion: controller.religion!,
        ),
      );
    } else {
      Get.snackbar(
        'Fields are empty',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}

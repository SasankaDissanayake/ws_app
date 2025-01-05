import 'package:app/source/account_create/components/drop_down_field.dart';
import 'package:app/source/account_create/controllers/account_create_controller1.dart';
import 'package:app/source/account_create/screens/third_step.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondStep extends StatelessWidget {
  final AccountCreateController1 controller =
      Get.put(AccountCreateController1());

  final String name;
  final String phoneNumber;
  final String fullName;
  final String promo;
  final DateTime birthday;
  final int accountFor;
  final int gender;

  SecondStep({
    super.key,
    required this.name,
    required this.fullName,
    required this.promo,
    required this.birthday,
    required this.accountFor,
    required this.gender,
    required this.phoneNumber,
  });
  final TextEditingController _descrip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;
    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tell us more about you!",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                "About you (profile description)",
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                minLines: 2,
                maxLines: 4,
                controller: _descrip,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 1.5,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.5,
                      ),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _showAlertDialog(
                            context,
                            Text(
                              'desEx'.tr,
                              style: TextStyle(
                                fontFamily:
                                    isEnglish ? 'Oswald' : 'GemunuLibre',
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                        icon: const Icon(Icons.question_mark_sharp))),
              ),
              const SizedBox(height: 30),
              isEnglish
                  ? Text(
                      "sCasteTit".tr,
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    )
                  : Text(
                      "sCasteTit".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildCasteOption("Yes", 0, isDark),
                  const SizedBox(width: 20),
                  _buildCasteOption("No", 1, isDark),
                ],
              ),
              GetBuilder<AccountCreateController1>(builder: (_) {
                return controller.sameCasteSearch == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 35),
                          isEnglish
                              ? Text(
                                  "casteTit".tr,
                                  style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                )
                              : Text(
                                  "casteTit".tr,
                                  style: GoogleFonts.gemunuLibre(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                          const SizedBox(height: 5),
                          Text(
                            "So you are looking for a partner in same caste as you. Tell us what your caste, Please?",
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownField(
                              dropDownList: caste, onChanged: casteOnChanged)
                        ],
                      )
                    : Container();
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            onPressed();
          },
          backgroundColor: isDark ? Colors.white : Colors.black,
          shape: const CircleBorder(),
          child: Icon(
            Icons.arrow_forward_ios,
            size: 30,
            color: isDark ? Colors.black : Colors.white,
          )),
    );
  }

  Widget _buildCasteOption(String label, int value, bool isDark) {
    return GetBuilder<AccountCreateController1>(builder: (_) {
      return Row(
        children: [
          Radio<int>(
            focusColor: isDark ? Colors.white : Colors.black,
            value: value,
            groupValue: controller.sameCasteSearch,
            onChanged: (int? newValue) {
              controller.updateSameCasteSearch(value);
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            activeColor: isDark ? Colors.white : Colors.black,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.openSans(
              fontSize: 17.5,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      );
    });
  }

  onPressed() {
    if (_descrip.text.isNotEmpty) {
      controller.description = _descrip.text;
      if (controller.sameCasteSearching != null) {
        if (controller.sameCasteSearching!) {
          if (controller.myCaste != null) {
            Get.off(ThirdStep(
              name: name,
              phoneNumber: phoneNumber,
              fullName: fullName,
              promo: promo,
              birthday: birthday,
              accountFor: accountFor,
              gender: gender,
              description: _descrip.text,
              sameCasteSearch: controller.sameCasteSearching!,
              myCaste: controller.myCaste!,
            ));
          } else {
            Get.snackbar(
              'Fields are empty',
              'Please fill all fields',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
            );
          }
        } else {
          Get.off(ThirdStep(
            name: name,
            phoneNumber: phoneNumber,
            fullName: fullName,
            promo: promo,
            birthday: birthday,
            accountFor: accountFor,
            gender: gender,
            description: _descrip.text,
            sameCasteSearch: controller.sameCasteSearching!,
            myCaste: -1,
          ));
        }
      } else {
        Get.snackbar(
          'Fields are empty',
          'Please fill all fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } else {
      Get.snackbar(
        'Fields are empty',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  casteOnChanged(int? value) {
    controller.updateMyCaste(value);
  }

  void _showAlertDialog(BuildContext context, Text note) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Example'),
        content: note,
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }
}

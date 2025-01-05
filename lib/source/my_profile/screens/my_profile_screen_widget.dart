import 'package:app/source/authentication/components/button.dart';
import 'package:app/source/authentication/controllers/authentication_repository.dart';
import 'package:app/source/my_profile/components/bday_.dart';
import 'package:app/source/my_profile/components/description.dart';
import 'package:app/source/my_profile/components/dropdown_field.dart';
import 'package:app/source/my_profile/components/points_adder.dart';
// import 'package:app/source/my_profile/components/skin_color.dart';
import 'package:app/source/my_profile/components/text_field.dart';
import 'package:app/source/my_profile/controllers/account_manager.dart';
import 'package:app/source/my_profile/screens/images_picker.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MyProfile extends StatelessWidget {
  final AccountManager controller = Get.put(AccountManager());
  final bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

  MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double size = Get.height / 3;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: isDark ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: isDark ? Colors.black : Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              'My Profile',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.put(AuthenticationRepository());
                  AuthenticationRepository.instance.signOut();
                },
                icon: const Icon(Icons.logout),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: controller.fetchMyProfile(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return _buildLoadingWidget(context);
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return profile(size);
                    } else {
                      return _buildNoDataWidget();
                    }
                  }
                  return _buildNoDataWidget(); // Default return
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profile(
    double size,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Profile images
        SizedBox(
          height: size + 100,
          child: Column(
            children: [
              Flexible(
                child: ProfileImages(
                  imagePickerController: controller.imagePickerController,
                ),
              ),
            ],
          ),
        ),

        //Skin color
        // controller.skinColor.value != -1
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Text(
        //             "Skin color",
        //             style: GoogleFonts.openSans(
        //                 fontSize: 15, fontWeight: FontWeight.w500),
        //           ),
        //           const SizedBox(
        //             height: 10,
        //           ),
        //           SkinColor(selectedSkinColor: controller.skinColor),
        //         ],
        //       )
        //     : Container(),

        const SizedBox(height: 15),

        //Name
        Text(
          "Name",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),

        TextFiled(controller: controller.name),
        const SizedBox(height: 15),

        //Birthday
        Text(
          "Birthday",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        BirthDayField(controller: controller.birthday),
        const SizedBox(height: 15),

        //Account for
        Text(
          "Account created for",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: accountFor,
          onChanged: controller.accountForOnChanged,
          initVaue: controller.accountFor != null
              ? accountFor[controller.accountFor!]
              : null,
        ),
        const SizedBox(height: 15),

        //Profile description
        Text(
          "Profile description",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        ProfileDescriptionField(controller: controller.description),
        const SizedBox(height: 15),

        Text(
          "Same caste searching",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: lookingForSameCaste,
          onChanged: controller.sameCasteSearchingOnChanged,
          initVaue: controller.sameCasteSearching! == true
              ? lookingForSameCaste[0]
              : lookingForSameCaste[1],
        ),
        const SizedBox(height: 15),

        //Caste
        GetBuilder<AccountManager>(builder: (_) {
          return controller.sameCasteSearching!
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My caste",
                      style: GoogleFonts.openSans(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    CustomDropdownField(
                      dropDownList: caste,
                      onChanged: controller.myCasteOnChanged,
                      initVaue: controller.myCaste == null
                          ? null
                          : caste[controller.myCaste!],
                    ),
                    const SizedBox(height: 15),
                  ],
                )
              : Container();
        }),

        //Height
        Text(
          "Height",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: heights,
          onChanged: controller.onHeightChanged,
          initVaue: heights[controller.onHeightInited()],
        ),
        const SizedBox(height: 15),

        //Marraige status
        Text(
          "My marraige status",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: marraigeStatus,
          onChanged: controller.marraigeStatusOnChanged,
          initVaue: controller.marraigeStatus != null
              ? marraigeStatus[controller.marraigeStatus!]
              : null,
        ),
        const SizedBox(height: 15),
        Text(
          "Partner preferred marraige status",
          style:
              GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: prefferdMarraigeStatus,
          onChanged: controller.prefMarraigeStatusOnChanged,
          initVaue: controller.prefMarraigeStatus != null
              ? prefferdMarraigeStatus[controller.prefMarraigeStatus!]
              : null,
        ),
        const SizedBox(height: 15),

        Text(
          "Kids preferences",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: kidsPreferences,
          onChanged: controller.kidsOnChanged,
          initVaue: kidsPreferences[controller.kids!],
        ),
        const SizedBox(height: 15),

        //Town
        Text(
          "Full name",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        TextFiled(controller: controller.fullname),
        const SizedBox(height: 15),

        //District
        Text(
          "District",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: districs,
          onChanged: controller.districtOnChanged,
          initVaue: districs[controller.district!],
        ),
        const SizedBox(height: 15),

        //Race
        Text(
          "Race",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: race,
          onChanged: controller.raceOnChanged,
          initVaue: race[controller.race!],
        ),
        const SizedBox(height: 15),

        //Religion
        Text(
          "Religion",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: religion,
          onChanged: controller.religionOnChanged,
          initVaue: religion[controller.religion!],
        ),
        const SizedBox(height: 15),

        //Education level
        Text(
          "Education level",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: eduLevel,
          onChanged: controller.myEduLvelOnChanged,
          initVaue: controller.myEduLvel != null
              ? eduLevel[controller.myEduLvel!]
              : null,
        ),
        const SizedBox(height: 15),

        //Partner preferred education level
        Text(
          "Partner preferred education level",
          style:
              GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: prefMinEduLevel,
          onChanged: controller.prefEduLvelOnChanged,
          initVaue: controller.prefEduLevl != null
              ? prefMinEduLevel[controller.prefEduLevl!]
              : null,
        ),
        const SizedBox(height: 15),

        //Educatinal achievements
        Text(
          "Educatinal achievements",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        PointsAdderEduAchives(),
        const SizedBox(height: 15),

        //Education place
        Text(
          "Education place",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        PointsAdderEduPlc(),
        const SizedBox(height: 15),

        //My drinking habits
        Text(
          "My drinking habits",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: drinkingHabits,
          onChanged: controller.myDrinkingHabitsOnChaged,
          initVaue: controller.myDrinkingHabits != null
              ? drinkingHabits[controller.myDrinkingHabits!]
              : null,
        ),
        const SizedBox(height: 15),

        //My smoking habits
        Text(
          "My smoking habits",
          style:
              GoogleFonts.openSans(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: smokingHabits,
          onChanged: controller.mySmokingHabitsOnChaged,
          initVaue: controller.mySmokingHabits != null
              ? smokingHabits[controller.mySmokingHabits!]
              : null,
        ),
        const SizedBox(height: 15),

        //Partner preferred drinking habits
        Text(
          "Partner preferred drinking habits",
          style:
              GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: partPrefDrinkHabs,
          onChanged: controller.partnerPrefferedDrinkingHabitsOnChaged,
          initVaue: controller.partnerPrefferedDrinkingHabits != null
              ? partPrefDrinkHabs[controller.partnerPrefferedDrinkingHabits!]
              : null,
        ),
        const SizedBox(height: 15),

        //Partner preferred smoking habits
        Text(
          "Partner preferred smoking habits",
          style:
              GoogleFonts.openSans(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        CustomDropdownField(
          dropDownList: partPrefSmokHabs,
          onChanged: controller.partnerPrefferedSmokingHabitsOnChaged,
          initVaue: controller.partnerPrefferedSmokingHabits != null
              ? partPrefSmokHabs[controller.partnerPrefferedSmokingHabits!]
              : null,
        ),
        const SizedBox(height: 30),
        Obx(
          () => ReusableButton(
            onTap: () {
              controller.updateProfile();
            },
            text: 'S A V E',
            isLoading: controller.isLoading.value,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildErrorWidget(dynamic error) {
    if (error is FirebaseException) {
      final firebaseException = error;
      if (firebaseException.code == 'permission-denied') {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                errorAnimation,
                height: 150,
                repeat: true,
              ),
              Text(
                "Wait for account approval, \nplease🙄!",
                style: GoogleFonts.oswald(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              isEnglish
                  ? Text(
                      "approval".tr,
                      style: GoogleFonts.oswald(
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      "approval".tr,
                      style: GoogleFonts.gemunuLibre(
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ],
          ),
        );
      } else {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                errorAnimation,
                height: 150,
                repeat: true,
              ),
              Text(
                "Oops! Something went wrong.",
                style: GoogleFonts.oswald(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "$error",
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(color: Colors.redAccent),
              ),
            ],
          ),
        );
      }
    } else {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              errorAnimation,
              height: 150,
              repeat: true,
            ),
            Text(
              "Oops! Something went wrong.",
              style: GoogleFonts.oswald(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$error",
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(color: Colors.redAccent),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildLoadingWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Lottie.asset(
          loadingAnimation,
          repeat: true,
        ),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Container(color: Colors.red);
  }
}

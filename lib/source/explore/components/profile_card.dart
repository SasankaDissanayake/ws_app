import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:app/source/explore/components/description.dart';
import 'package:app/source/explore/components/points.dart';
import 'package:app/source/explore/components/text_to_field.dart';
import 'package:app/source/references/data_collection.dart';
import 'package:app/source/references/explore_profile_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileCard extends StatelessWidget {
  final ExploreProfileModel profile;
  const ProfileCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: Get.width,
          height: Get.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: profile.backgroundImage!),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: SizedBox(
                    height: Get.height / 2,
                    child: AnotherCarousel(
                      images: profile.imageUrls.isEmpty
                          ? profile.gender == 0
                              ? const [AssetImage(malePlaceHolder)]
                              : const [AssetImage(femalePlaceHolder)]
                          : getImages(profile.imageUrls, profile.gender),
                      borderRadius: true,
                      autoplay: false,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Description(
                  text: profile.description,
                ),

                const SizedBox(height: 10),

                // Skin color
                // profile.imageUrls.isEmpty && profile.skinColor != -1
                //     ? Column(
                //         children: [
                //           SkinColorA(index: profile.skinColor),
                //           const SizedBox(height: 10),
                //         ],
                //       )
                //     : Container(),

                TitleToFiled(
                  title: 'Name',
                  field: profile.name,
                  icon: const FaIcon(FontAwesomeIcons.signature),
                ),
                const SizedBox(height: 10),

                TitleToFiled(
                  title: 'Age',
                  field: calculateAge(profile.birthday),
                  icon: const FaIcon(FontAwesomeIcons.cakeCandles),
                ),
                const SizedBox(height: 10),

                TitleToFiled(
                  title: 'Accout created for',
                  field: accountFor[profile.accountFor],
                  icon: const FaIcon(FontAwesomeIcons.userCheck),
                ),
                const SizedBox(height: 10),

                //If caste matter?
                profile.sameCasteSearch
                    ? Column(
                        children: [
                          TitleToFiled(
                            title: 'Caste',
                            field: caste[profile.myCaste],
                            icon: const FaIcon(FontAwesomeIcons.peopleGroup),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 0),

                //Marraige status
                TitleToFiled(
                    title: 'Height',
                    field: '${profile.ft}.${profile.inch}ft',
                    icon: const FaIcon(FontAwesomeIcons.upLong)),
                const SizedBox(height: 10),

                //Marraige status
                TitleToFiled(
                  title: 'Marriage status',
                  field: marraigeStatus[profile.myMarraige],
                  imageIcon: const ImageIcon(
                    AssetImage(ringImage),
                  ),
                ),
                const SizedBox(height: 10),

                //Partner preferred marraige status
                TitleToFiled(
                  title: 'Partner preferred marriage status',
                  field: "\n${prefferdMarraigeStatus[profile.prefMarraige]}",
                  imageIcon: const ImageIcon(
                    AssetImage(ringImage),
                  ),
                ),
                const SizedBox(height: 10),

                //Kids
                TitleToFiled(
                  title: 'Kids preferences',
                  field: "${kidsPreferences[profile.kids]}",
                  icon: const FaIcon(FontAwesomeIcons.baby),
                ),
                const SizedBox(height: 10),

                //Qualities
                const Text(
                  "Preferred qualities",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Points(list: profile.qualities),
                const SizedBox(
                  height: 10,
                ),

                //Lives in
                TitleToFiled(
                  title: 'Lives in',
                  field: districs[profile.district],
                  icon: const FaIcon(FontAwesomeIcons.mapLocation),
                ),
                const SizedBox(height: 10),

                //Educatinal level
                TitleToFiled(
                  title: 'Educatinal level',
                  field: eduLevel[profile.myEduLvel],
                  iconNative: const Icon(Icons.school),
                ),
                const SizedBox(height: 10),

                //Educatinal achivements if not empty
                profile.eduAchi.isNotEmpty
                    ? Column(
                        children: [
                          const Text(
                            "Educatinal achivements",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Points(
                              list: profile.eduAchi,
                              icon: const Icon(Icons.school),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 0),

                //Educated places if not empty
                profile.eduPlcs.isNotEmpty
                    ? Column(
                        children: [
                          const Text(
                            "Educated places",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Points(
                              list: profile.eduPlcs,
                              faIcon: const FaIcon(
                                  FontAwesomeIcons.schoolCircleCheck),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 0),

                //Partner preferred eduvatinal level
                TitleToFiled(
                  title: 'Partner preferred eduvatinal level',
                  field: "\n${prefMinEduLevel[profile.prefEduLevl]}",
                  icon: const FaIcon(FontAwesomeIcons.schoolLock),
                ),
                const SizedBox(height: 10),

                //Add job position and work place if it not null
                profile.jobPos.isNotEmpty
                    ? Column(
                        children: [
                          TitleToFiled(
                            title: 'Working',
                            field: getWorkingAs(
                                profile.jobPos, "\n${profile.workPlc}"),
                            iconNative: const Icon(Icons.work),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 0),

                //Race
                TitleToFiled(
                  title: 'Race',
                  field: race[profile.race],
                  iconNative: const Icon(Icons.people),
                ),
                const SizedBox(height: 10),

                //Religion
                TitleToFiled(
                  title: 'Religion',
                  field: religion[profile.religion],
                  icon: const FaIcon(FontAwesomeIcons.personPraying),
                ),
                const SizedBox(height: 10),

                //My drinking habits
                TitleToFiled(
                  title: 'Drinking Habits',
                  field: drinkingHabits[profile.myDrinks],
                  icon: const FaIcon(FontAwesomeIcons.wineGlass),
                ),
                const SizedBox(height: 10),

                //My smoking habits
                TitleToFiled(
                  title: 'Smoking Habits',
                  field: smokingHabits[profile.mySmokes],
                  icon: const FaIcon(FontAwesomeIcons.joint),
                ),
                const SizedBox(height: 10),

                TitleToFiled(
                  title: 'Partner Preferred Drinking Habits',
                  field: "\n${partPrefDrinkHabs[profile.prefDrinks]}",
                  icon: const FaIcon(FontAwesomeIcons.wineGlass),
                ),
                const SizedBox(height: 10),

                //Partner preffered smoking habits

                TitleToFiled(
                  title: 'Partner Preferred Smoking Habits',
                  field: "\n${partPrefSmokHabs[profile.prefSmokes]}",
                  icon: const FaIcon(FontAwesomeIcons.joint),
                ),

                const SizedBox(height: 100),

                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImages(List<String> images, int gender) {
    if (images.isEmpty) {
      List<dynamic> images = [];

      if (gender == 0) {
        images[0] = const AssetImage(malePlaceHolder);
        return images;
      } else {
        images[0] = const AssetImage(femalePlaceHolder);
        return images;
      }
    } else {
      int legnth = images.length;
      List<dynamic> imageUrls = [];
      for (var i = 0; i < legnth; i++) {
        imageUrls.add(
          Image.network(
            images[i],
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                  backgroundColor: Colors.white,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        );
      }

      return imageUrls;
    }
  }

  getWorkingAs(String job, String workPlc) {
    return '$job as $workPlc';
  }

  String calculateAge(DateTime birthYear) {
    final now = DateTime.now();
    final differenceInDays = now.difference(birthYear).inDays;
    final years = differenceInDays ~/ (365.25);
    final age = years.abs();
    return '$age';
  }
}

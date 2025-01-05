import 'package:app/source/explore/controllers/explore_repository.dart';
import 'package:app/source/references/image_references.dart';
import 'package:app/source/references/local_db_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Explore extends StatelessWidget {
  Explore({super.key});
  final bool isEnglish = LocalDbManager.getData('1') == 2 ? true : false;

  @override
  Widget build(BuildContext context) {
    Get.put(ExploreRepository());
    final width = Get.width;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: isDark ? Colors.black : Colors.white,
          appBar: AppBar(
            backgroundColor: isDark ? Colors.black : Colors.white,
            automaticallyImplyLeading: false,
            title: SizedBox(
              width: width / 2 - 30,
              child: Image.asset(appbarTitle),
            ),
          ),
          body: Stack(
            children: [
              GetBuilder<ExploreRepository>(builder: (_) {
                if (ExploreRepository.instance.hasError.value) {
                  return _buildErrorWidget();
                } else if (ExploreRepository.instance.isLoading.value) {
                  return _buildLoadingWidget(context);
                } else if (ExploreRepository.instance.isEndOfCollection.value) {
                  return _buildEndCollectionWidget(context);
                } else if (ExploreRepository.instance.nowCurrentIndex ==
                        ExploreRepository.instance.profiles.length &&
                    !ExploreRepository.instance.isEndOfCollection.value) {
                  return _buildLoadingWidget(context);
                } else {
                  return CardSwiper(
                    controller: ExploreRepository.instance.cardSwiperController,
                    cardsCount: ExploreRepository.instance.profiles.length,
                    onSwipe: (previousIndex, currentIndex, direction) =>
                        ExploreRepository.instance
                            .onSwipe(previousIndex, currentIndex, direction),
                    numberOfCardsDisplayed: 2,
                    backCardOffset: const Offset(5, 5),
                    padding: const EdgeInsets.all(10),
                    allowedSwipeDirection: const AllowedSwipeDirection.only(
                        left: true, right: true),
                    cardBuilder: (
                      context,
                      index,
                      horizontalThresholdPercentage,
                      verticalThresholdPercentage,
                    ) =>
                        ExploreRepository.instance.profiles[index],
                    isLoop: false,
                    onEnd: ExploreRepository.instance.collectionOver,
                  );
                }
              }),
              _buttons(),
            ],
          ),
        ),
      ),
    );
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

  Widget _buildEndCollectionWidget(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                sorryAnimation,
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
                "No more profiles left!...",
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(color: Colors.redAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
                onPressed: () {
                ExploreRepository.instance.cardSwiperController
                    .swipe(CardSwiperDirection.left);
              },

              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 50,
                  child: Image.asset(nopeIcon),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ElevatedButton(
              onPressed: () async {
                ExploreRepository.instance.cardSwiperController
                    .swipe(CardSwiperDirection.right);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 50,
                  child: Image.asset(inviteIcon),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              sorryAnimation,
              height: 150,
              repeat: true,
            ),
            Text(
              "Wait till we approve your account",
              style: GoogleFonts.oswald(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ExploreRepository.instance.error?.code == 'permission-denied'
                ? isEnglish
                    ? Text(
                        "profApp".tr,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "profApp".tr,
                        style: GoogleFonts.gemunuLibre(
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                : Text(
                    "${ExploreRepository.instance.error?.message}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.oswald(color: Colors.redAccent),
                  )
          ],
        ),
      ),
    );
  }
}

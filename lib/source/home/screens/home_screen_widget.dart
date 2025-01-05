import 'package:app/source/account_create/screens/init_step.dart';
import 'package:app/source/home/controller/home_navigation_controller.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final HomeNavigationController controller =
      Get.put(HomeNavigationController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getMyProfile(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget(context);
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!) {
            return _buildHomeScreen(context);
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error);
          } else if (!(snapshot.data!)) {
            //Create profile
            return InitStep();
          } else {
            return _buildNoDataWidget();
          }
        }
        return _buildNoDataWidget(); // Default return
      },
    );
  }

  Widget _buildErrorWidget(dynamic error) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              errorAnimation,
              height: 150,
              repeat: true,
            ),
            const Text(
              "Oops! Something went wrong.",
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$error",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Oswald',
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Center(
        child: Lottie.asset(
          loadingAnimation,
          repeat: true,
        ),
      ),
    );
  }

  Widget _buildHomeScreen(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isDark ? Colors.white : Colors.black,
                width: 0.3,
              ),
            ),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
                (Set<WidgetState> states) =>
                    states.contains(WidgetState.selected)
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : const TextStyle(fontWeight: FontWeight.w200),
              ),
            ),
            child: NavigationBar(
              indicatorColor: Colors.transparent,
              elevation: 10,
              backgroundColor: isDark ? Colors.black : Colors.white,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              animationDuration: const Duration(milliseconds: 250),
              height: 60,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (value) =>
                  controller.onDestinationSelected(value),
              destinations: const [
                NavigationDestination(
                  icon: ImageIcon(AssetImage(exploreIcon)),
                  selectedIcon: ImageIcon(AssetImage(exploreIconSelected)),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: ImageIcon(AssetImage(chatsIcon)),
                  selectedIcon: ImageIcon(AssetImage(chatsIconSelected)),
                  label: 'Chats',
                ),
                NavigationDestination(
                  icon: ImageIcon(AssetImage(profileIcon)),
                  selectedIcon: ImageIcon(AssetImage(profileIconSelected)),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }

  Widget _buildNoDataWidget() {
    return Container(color: Colors.red);
  }
}

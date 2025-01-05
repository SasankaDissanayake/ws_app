import 'package:app/source/references/data_collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkinColor extends StatelessWidget {
  final RxInt selectedSkinColor;
  const SkinColor({super.key, required this.selectedSkinColor});

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return Center(
      child: Obx(
        () => Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(skinColors.length, (index) {
            return GestureDetector(
              onTap: () {
                selectedSkinColor.value = index;
              },
              child: Container(
                width: width / 8,
                height: 50,
                decoration: BoxDecoration(
                  color: skinColors[index],
                  border: Border.all(
                    color: selectedSkinColor.value == index
                        ? isDark
                            ? Colors.white
                            : Colors.black
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

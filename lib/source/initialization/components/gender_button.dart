import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenScrnButtoon extends StatelessWidget {
  final Text text;
  final void Function()? onTap;
  final AssetImage image;
  final bool isSelected;
  final double tenPx;

  const GenScrnButtoon({
    super.key,
    required this.text,
    this.onTap,
    required this.image,
    required this.isSelected,
    required this.tenPx,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark
              ? isSelected
              ? Colors.black
              : Colors.black.withOpacity(0.5)
              : isSelected
              ? Colors.white
              : Colors.white.withOpacity(0.5),
        ),
        padding:
        EdgeInsets.fromLTRB(tenPx * 4, tenPx * 8, tenPx * 4, tenPx * 8),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: tenPx * 7,
                child: Image(image: image),
              ),
              SizedBox(
                width: tenPx * 3,
              ),
              text
            ],
          ),
        ),
      ),
    );
  }
}

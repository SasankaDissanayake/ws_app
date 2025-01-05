import 'package:flutter/material.dart';

class LangScrnButtoon extends StatelessWidget {
  final Text text;
  final void Function()? onTap;
  final AssetImage image;
  final bool isSelected;
  final double tenPx;

  const LangScrnButtoon({
    super.key,
    required this.text,
    this.onTap,
    required this.image,
    required this.isSelected,
    required this.tenPx,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

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
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        margin: EdgeInsets.symmetric(horizontal: tenPx * 6),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: tenPx * 2.5,
                child: Image(image: image),
              ),
              SizedBox(
                width: tenPx,
              ),
              text,
            ],
          ),
        ),
      ),
    );
  }
}

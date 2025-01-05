import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TitleToFiled extends StatelessWidget {
  final String title;
  final String field;
  final FaIcon? icon;
  final ImageIcon? imageIcon;
  final Icon? iconNative;

  const TitleToFiled({
    super.key,
    required this.title,
    required this.field,
    this.icon,
    this.imageIcon,
    this.iconNative,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              returnIcon(),
              const SizedBox(
                width: 5,
              ),
              Text.rich(
                textAlign: TextAlign.start,
                TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "$title:",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  TextSpan(
                    text: " $field",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  returnIcon() {
    if (icon != null) {
      return icon;
    } else if (imageIcon != null) {
      return imageIcon;
    } else if (iconNative != null) {
      return iconNative;
    } else {
      return Icon(Icons.help);
    }
  }
}

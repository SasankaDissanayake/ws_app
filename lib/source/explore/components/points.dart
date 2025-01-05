import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Points extends StatelessWidget {
  final List<String> list;
  final Icon? icon;
  final FaIcon? faIcon;

  const Points({
    super.key,
    required this.list,
    this.icon,
    this.faIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list
            .map(
              (item) => Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        returnIcon(),
                        Text(" ${item}"),
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  returnIcon() {
    if (icon != null) {
      return icon;
    } else if (faIcon != null) {
      return faIcon;
    } else {
      return Icon(Icons.help);
    }
  }
}

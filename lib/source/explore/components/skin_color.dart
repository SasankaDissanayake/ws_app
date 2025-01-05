import 'package:app/source/references/data_collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SkinColorA extends StatelessWidget {
  final int index;

  const SkinColorA({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

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
              const SizedBox(
                width: 5,
              ),
              const Text(
                "Skin color: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                width: Get.width / 2,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: skinColors[index],
                  border: Border.all(
                    color: isDark ? Colors.white : Colors.black,
                    width: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

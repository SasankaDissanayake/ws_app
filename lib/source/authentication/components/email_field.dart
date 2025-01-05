import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode = FocusNode();
  final void Function()? onTap;

  EmailField({
    super.key,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    final color = isDark ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextField(
        onTap: onTap,
        onChanged: (value) {
          if (value.isEmpty) focusNode.unfocus();
        },
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          labelText: 'Email',
          labelStyle: TextStyle(
            color: color,
          ),
          hintText: 'name@example.com',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}

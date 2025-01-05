import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool showPassword;
  final void Function() onTap;
  final FocusNode focusNode = FocusNode();

  PasswordField({
    super.key,
    required this.showPassword,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    final color = isDark ? Colors.white : Colors.black;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextField(
        onChanged: (value) {
          if (value.isEmpty) focusNode.unfocus();
        },
        obscureText: showPassword,
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blueAccent),
          ),
          labelText: 'Password',
          labelStyle: TextStyle(
            color: color,
          ),
          hintText: 'Enter your password here!',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}

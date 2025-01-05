import 'package:flutter/material.dart';

class ProfileDescriptionField extends StatelessWidget {
  final TextEditingController controller;

  const ProfileDescriptionField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: TextField(
        controller: controller,
        minLines: 1,
        maxLines: 4,
        decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}

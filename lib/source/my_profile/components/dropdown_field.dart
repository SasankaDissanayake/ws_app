import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final List<String> dropDownList;
  final void Function(int? value) onChanged;
  final IconButton? suffixIcon;
  final String? initVaue;

  const CustomDropdownField({
    super.key,
    required this.dropDownList,
    required this.onChanged,
    this.suffixIcon,
    this.initVaue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: DropdownButtonFormField(
        value: initVaue,
        decoration: InputDecoration(
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
          ),
          suffixIcon: suffixIcon,
        ),
        onChanged: (value) => onChanged(dropDownList.indexOf(value!)),
        items: dropDownList
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

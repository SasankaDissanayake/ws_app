import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final List<String> dropDownList;
  final void Function(int? value) onChanged;
  final IconButton? suffixIcon;
  const DropdownField({
    super.key,
    required this.dropDownList,
    required this.onChanged,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 0, left: 0),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.5,
            ),
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

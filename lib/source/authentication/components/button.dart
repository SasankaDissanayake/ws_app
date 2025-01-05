import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool isLoading;

  const ReusableButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [
                Colors.yellow,
                Colors.orange,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                  )
                : Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
          ),
        ),
      ),
    );
  }
}

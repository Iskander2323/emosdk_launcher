import 'package:flutter/material.dart';

class CustomInkWellButton extends StatelessWidget {
  const CustomInkWellButton({super.key, required this.buttonText, required this.onPressed, this.isEnabled = true});

  final String buttonText;
  final VoidCallback? onPressed;
  final bool isEnabled;



  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: isEnabled ? Colors.green : Colors.grey,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: isEnabled ? onPressed : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          height: 60,
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
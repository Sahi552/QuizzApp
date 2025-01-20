import 'package:flutter/material.dart';
import 'package:quiz_game/core/theme/theme.dart';

class Button extends StatelessWidget {
  final String buttonText;
  const Button({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: AppTheme.colorGradient,
      ),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          buttonText,
          style: AppTheme.btnTxt,
        ),
      )),
    );
  }
}

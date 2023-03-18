import 'package:flutter/material.dart';

class CustomTextButtonStyle extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  CustomTextButtonStyle({
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(color: textColor, fontSize: fontSize, inherit: false)),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        padding: EdgeInsets.all(12),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Sign Up'),
    );
  }
}

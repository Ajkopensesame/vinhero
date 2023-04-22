import 'package:flutter/material.dart';

class SignInLink extends StatelessWidget {
  const SignInLink({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            const SizedBox(width: 5),
            TextButton(
              onPressed: onPressed,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

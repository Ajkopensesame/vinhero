import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final String logoFileName;

  const LogoWidget({super.key, required this.logoFileName});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/car_logos/logos/optimized/$logoFileName');
  }
}

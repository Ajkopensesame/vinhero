import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FixedHeader extends StatelessWidget {
  final String? logoFileName;
  final List<Map<String, String>> savedVehicles;
  const FixedHeader({Key? key, this.logoFileName, required this.savedVehicles, required Map<String, String> vehicleInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Saved vehicles: $savedVehicles'); // Add this line to print saved vehicles list

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200.0,
          child: Image.asset(
            logoFileName != null
                ? 'assets/car_logos/logos/optimized/${logoFileName!.toLowerCase()}'
                : _getRandomMakeLogo(savedVehicles),
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

  String _getRandomMakeLogo(List<Map<String, String>> vehicles) {
    if (vehicles.isNotEmpty) {
      int randomIndex = Random().nextInt(vehicles.length);
      String make = vehicles[randomIndex]['make']!.toLowerCase();
      return 'assets/car_logos/logos/optimized/$make.png';
    } else {
      return 'assets/car_logos/logos/default_image.png'; // Replace with the path to your default image
    }
  }
}

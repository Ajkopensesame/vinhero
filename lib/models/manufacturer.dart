import 'package:flutter/material.dart';

class Manufacturer {
  final String name;
  final String logoAsset;
  final String imageUrl;
  final Color primaryColor;
  final Color secondaryColor;

  Manufacturer({
    required this.name,
    required this.logoAsset,
    required this.imageUrl,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

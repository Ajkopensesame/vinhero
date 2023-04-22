import 'package:flutter/material.dart';

class SafetyRatingsPage extends StatefulWidget {
  final String make;
  final String model;
  final String year;

  const SafetyRatingsPage({
    Key? key,
    required this.make,
    required this.model,
    required this.year,
  }) : super(key: key);

  @override
  _SafetyRatingsPageState createState() => _SafetyRatingsPageState();
}

class _SafetyRatingsPageState extends State<SafetyRatingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Safety Ratings')),
      body: Center(child: Text('Safety Ratings for ${widget.make} ${widget.model} ${widget.year}')),
    );
  }
}

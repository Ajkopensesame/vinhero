import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SafetyRatingsWidget extends StatefulWidget {
  final String make;
  final String model;
  final String year;

  SafetyRatingsWidget({required this.make, required this.model, required this.year});

  @override
  _SafetyRatingsWidgetState createState() => _SafetyRatingsWidgetState();
}

class _SafetyRatingsWidgetState extends State<SafetyRatingsWidget> {
  Map<String, dynamic> safetyRatings = {};

  @override
  void initState() {
    super.initState();
    _getSafetyRatings().then((value) => setState(() => safetyRatings = value));
  }

  Future<Map<String, dynamic>> _getSafetyRatings() async {
    String safetyRatingsUrl =
        'https://one.nhtsa.gov/webapi/api/SafetyRatings/modelyear/${widget.year}/make/${widget.make}/model/${widget.model}?format=json';
    var safetyRatingsResponse = await http.get(Uri.parse(safetyRatingsUrl));
    if (safetyRatingsResponse.statusCode == 200) {
      return jsonDecode(safetyRatingsResponse.body);
    } else {
      throw Exception('Failed to load safety ratings');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (safetyRatings.isEmpty) {
      return CircularProgressIndicator();
    } else {
      // You can customize the display of the safety ratings as needed.
      return Text('Safety ratings: ${safetyRatings.toString()}');
    }
  }
}

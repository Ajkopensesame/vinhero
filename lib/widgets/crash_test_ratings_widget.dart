import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrashTestRatingsWidget extends StatefulWidget {
  final String make;
  final String model;
  final String year;

  CrashTestRatingsWidget({required this.make, required this.model, required this.year});

  @override
  _CrashTestRatingsWidgetState createState() => _CrashTestRatingsWidgetState();
}

class _CrashTestRatingsWidgetState extends State<CrashTestRatingsWidget> {
  Map<String, dynamic> crashTestRatings = {};

  @override
  void initState() {
    super.initState();
    _getCrashTestRatings().then((value) => setState(() => crashTestRatings = value));
  }

  Future<Map<String, dynamic>> _getCrashTestRatings() async {
    String crashTestUrl =
        'https://one.nhtsa.gov/webapi/api/SafetyRatings/modelyear/${widget.year}/make/${widget.make}/model/${widget.model}?format=json';
    var crashTestResponse = await http.get(Uri.parse(crashTestUrl));
    if (crashTestResponse.statusCode == 200) {
      return jsonDecode(crashTestResponse.body);
    } else {
      throw Exception('Failed to load crash test ratings');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (crashTestRatings.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return Text('Crash test ratings: ${crashTestRatings.toString()}');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChildSeatRecallsWidget extends StatefulWidget {
  @override
  _ChildSeatRecallsWidgetState createState() => _ChildSeatRecallsWidgetState();
}

class _ChildSeatRecallsWidgetState extends State<ChildSeatRecallsWidget> {
  Map<String, dynamic> childSeatRecalls = {};

  @override
  void initState() {
    super.initState();
    _getChildSeatRecalls().then((value) => setState(() => childSeatRecalls = value));
  }

  Future<Map<String, dynamic>> _getChildSeatRecalls() async {
    String childSeatRecallsUrl = 'https://api.nhtsa.gov/recalls/childseats?format=json';
    var childSeatRecallsResponse = await http.get(Uri.parse(childSeatRecallsUrl));
    if (childSeatRecallsResponse.statusCode == 200) {
      return jsonDecode(childSeatRecallsResponse.body);
    } else {
      throw Exception('Failed to load child seat recalls');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (childSeatRecalls.isEmpty) {
      return CircularProgressIndicator();
    } else {
      // You can customize the display of the child seat recalls as needed.
      return Text('Child seat recalls: ${childSeatRecalls.toString()}');
    }
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecallsWidget extends StatefulWidget {
  final String make;
  final String model;
  final String year;

  RecallsWidget({required this.make, required this.model, required this.year});

  @override
  _RecallsWidgetState createState() => _RecallsWidgetState();
}

class _RecallsWidgetState extends State<RecallsWidget> {
  List<dynamic> recalls = [];

  @override
  void initState() {
    super.initState();
    _getRecalls().then((value) => setState(() => recalls = value));
  }

  Future<List<dynamic>> _getRecalls() async {
    String recallsUrl =
        'https://api.nhtsa.gov/recalls/vehicle?make=${widget.make}&model=${widget.model}&year=${widget.year}';
    var recallsResponse = await http.get(Uri.parse(recallsUrl));
    if (recallsResponse.statusCode == 200) {
      return jsonDecode(recallsResponse.body)['results'];
    } else {
      throw Exception('Failed to load recalls');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recalls.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: recalls.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Recall ${index + 1}'),
            subtitle: Text('Summary: ${recalls[index]['summary']}'),
          );
        },
      );
    }
  }
}

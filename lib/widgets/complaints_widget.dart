import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ComplaintsWidget extends StatefulWidget {
  final String make;
  final String model;
  final String year;

  ComplaintsWidget({required this.make, required this.model, required this.year});

  @override
  _ComplaintsWidgetState createState() => _ComplaintsWidgetState();
}

class _ComplaintsWidgetState extends State<ComplaintsWidget> {
  List<dynamic> complaints = [];

  @override
  void initState() {
    super.initState();
    _getComplaints().then((value) => setState(() => complaints = value));
  }

  Future<List<dynamic>> _getComplaints() async {
    String complaintsUrl =
        'https://api.nhtsa.gov/complaints/v1/vehicle/${widget.make}/${widget.model}/${widget.year}?format=json';
    var complaintsResponse = await http.get(Uri.parse(complaintsUrl));
    if (complaintsResponse.statusCode == 200) {
      return jsonDecode(complaintsResponse.body)['results'];
    } else {
      throw Exception('Failed to load complaints');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (complaints.isEmpty) {
      return CircularProgressIndicator();
    } else {
      return ListView.builder(
        itemCount: complaints.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Complaint ${index + 1}'),
            subtitle: Text('Component: ${complaints[index]['component']}'),
          );
        },
      );
    }
  }
}

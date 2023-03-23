import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PartsPage extends StatefulWidget {
  final String vin;

  PartsPage({required this.vin});

  @override
  _PartsPageState createState() => _PartsPageState();
}

class _PartsPageState extends State<PartsPage> {
  List<dynamic> _partsData = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getPartsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parts'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _partsData.isEmpty
            ? Text('No parts data found')
            : ListView.builder(
          itemCount: _partsData.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_partsData[index]['partName']),
              subtitle: Text(_partsData[index]['partNumber']),
              leading: Icon(Icons.auto_awesome),
            );
          },
        ),
      ),
    );
  }

  void _getPartsData() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(
      Uri.parse('https://example.com/api/parts?vin=${widget.vin}'),
    );
    setState(() {
      _isLoading = false;
      if (response.statusCode == 200) {
        _partsData = jsonDecode(response.body);
      } else {
        _partsData = [];
      }
    });
  }
}

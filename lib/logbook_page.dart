import 'package:flutter/material.dart';

class LogbookPage extends StatelessWidget {
  final String vin;

  LogbookPage({required this.vin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logbook'),
      ),
      body: ListView(
        children: [
          _buildLogEntry(context, mileage: 5000),
          _buildLogEntry(context, mileage: 10000),
          _buildLogEntry(context, mileage: 15000),
          // Add more log entries as necessary
        ],
      ),
    );
  }

  Widget _buildLogEntry(BuildContext context, {required int mileage}) {
    return ListTile(
      leading: Icon(Icons.directions_car),
      title: Text('$mileage miles'),
      trailing: ElevatedButton(
        onPressed: () {
          // Add navigation to maintenance report page for this mileage
        },
        child: Text('View Report'),
      ),
    );
  }
}

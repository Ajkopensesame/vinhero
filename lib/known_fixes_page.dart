import 'package:flutter/material.dart';

class KnownFixesPage extends StatelessWidget {
  final String make;
  final String model;
  final String year;
  final String code;
  final String description;
  final List<String> possibleCauses;

  KnownFixesPage({
    required this.make,
    required this.model,
    required this.year,
    required this.code,
    required this.description,
    required this.possibleCauses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Known Fixes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$make $model $year',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Error Code: $code',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Description: $description',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Possible Causes:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: possibleCauses.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    possibleCauses[index],
                    style: TextStyle(fontSize: 16.0),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

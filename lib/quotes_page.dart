import 'package:flutter/material.dart';

class QuotesPage extends StatelessWidget {
  final List<Repair> _repairs = [
    Repair(
      description: 'Replace brake pads and rotors',
      cost: 300,
    ),
    Repair(
      description: 'Replace battery',
      cost: 150,
    ),
    Repair(
      description: 'Replace alternator',
      cost: 400,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: _repairs.isEmpty
          ? Center(child: Text('No repairs found.'))
          : ListView.builder(
        itemCount: _repairs.length,
        itemBuilder: (context, index) {
          final repair = _repairs[index];
          return ListTile(
            title: Text(repair.description),
            subtitle: Text('\$${repair.cost}'),
          );
        },
      ),
    );
  }
}

class Repair {
  final String description;
  final double cost;

  Repair({required this.description, required this.cost});
}

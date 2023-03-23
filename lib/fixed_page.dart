import 'package:flutter/material.dart';

class FixedPage extends StatefulWidget {
  @override
  _FixedPageState createState() => _FixedPageState();
}

class _FixedPageState extends State<FixedPage> {
  List<Problem> _problems = [
    Problem(
      description: 'Engine misfires',
      fix: 'Replace spark plugs and ignition coils',
    ),
    Problem(
      description: 'Brakes squeak',
      fix: 'Replace brake pads and rotors',
    ),
    Problem(
      description: 'Battery dies frequently',
      fix: 'Replace battery and check alternator',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixed'),
      ),
      body: _problems.isEmpty
          ? Center(child: Text('No problems found.'))
          : ListView.builder(
        itemCount: _problems.length,
        itemBuilder: (context, index) {
          final problem = _problems[index];
          return ListTile(
            title: Text(problem.description),
            subtitle: Text(problem.fix),
          );
        },
      ),
    );
  }
}

class Problem {
  final String description;
  final String fix;

  Problem({required this.description, required this.fix});
}

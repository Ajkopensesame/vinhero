import 'package:cloud_firestore/cloud_firestore.dart';

class Problem {
  final String id;
  final String title;
  final String description;
  final String make;
  final String model;
  final String year;

  Problem({
    required this.id,
    required this.title,
    required this.description,
    required this.make,
    required this.model,
    required this.year,
  });

  factory Problem.fromDocument(DocumentSnapshot doc) {
    return Problem(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
      make: doc['make'],
      model: doc['model'],
      year: doc['year'],
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

Widget VehicleDetails(DocumentSnapshot vehicle, {required vehicleData}) {
  final data = vehicle.data() as Map<String, dynamic>;

  final make = data['vehicleData']['Make'] ?? '';
  final model = data['vehicleData']['Model'] ?? '';
  final year = data['vehicleData']['Model Year'] ?? '';

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('$make $model $year', style: TextStyle(fontSize: 16.0)),
    ],
  );
}

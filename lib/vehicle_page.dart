import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vinhero/saved_vehicle_list.dart';

import 'fixed_header.dart';

class VehiclePage extends StatefulWidget {
  final Stream<QuerySnapshot<Map<String, dynamic>>>? savedVehiclesStream;

  const VehiclePage({Key? key, required this.savedVehiclesStream})
      : super(key: key);

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  List<Map<String, dynamic>> _savedVehicles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicles'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: widget.savedVehiclesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _savedVehicles = snapshot.data!.docs
                      .map((doc) => {
                    'make': doc.data()['vehicleData']['Make'],
                    'model': doc.data()['vehicleData']['Model'],
                    'year': doc.data()['vehicleData']['Model Year'],
                  })
                      .toList();
                  return SavedVehicleList(savedVehicles: _savedVehicles);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

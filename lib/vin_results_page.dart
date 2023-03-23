import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vinhero/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VinResultsPage extends StatelessWidget {
  final Map<String, dynamic> vehicleData;
  final String vin;

  VinResultsPage({Key? key, required this.vehicleData, required this.vin}) : super(key: key) {
    if (kDebugMode) {
      print('Vehicle Data: $vehicleData');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VIN Results'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildVehicleDetails(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveVinToProfile(context);
              },
              child: const Text('Save to My Vehicles'),
            ),
          ],
        ),
      ),
    );
  }


  List<Widget> _buildVehicleDetails() { // Check if the vehicleData contains Make, Model, and Model Year
    if (vehicleData['Make'] == null || vehicleData['Model'] == null || vehicleData['Model Year'] == null) {
      return [
        const Center(
          child: Text(
            'Vehicle information is incomplete.',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ];
    }
    List<String> keysToDisplay = [
      'VIN',
      'WorldManufacturerIdentifier',
      'Make',
      'Model',
      'Model Year',
      'BodyClass',
      'Doors',
      'BedLengthIN',
      'WheelBaseShortIN',
      'WheelBaseLongIN',
      'GrossVehicleWeightRating',
      'BrakeSystemType',
      'EngineModel',
      'EngineHP',
      'EngineCylinders',
      'DisplacementL',
      'TransmissionStyle',
      'TransmissionSpeeds',
      'DriveType',
      'FuelTypePrimary',
      'FuelTypeSecondary',
      'FuelInjectionType',
      'Turbo',
      'Supercharger',
      'EngineElectrification',
      'EngineElectrificationKW',
      'EngineElectrificationHP',
      'BatteryType',
      'BatteryCapacityKWh',
      'BatteryCurrentA',
      'BatteryVoltageV',
      'Series',
      'Series2',
      'VehicleType',
      'Trim',
      'Trim2',
      'PlantCountry',
      'PlantState',
      'PlantCity',
    ];

    List<Widget> vehicleDetails = [];

    for (var key in keysToDisplay) {
      if (vehicleData.containsKey(key) &&
          vehicleData[key] != null &&
          vehicleData[key]
              .toString()
              .isNotEmpty) {
        vehicleDetails.add(
          ListTile(
            title: Text(
              '$key:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(vehicleData[key].toString()),
            leading: const Icon(Icons.directions_car),
          ),
        );
      }
    }

    return vehicleDetails;
  }

  void _saveVinToProfile(BuildContext context) async {
    // Get the user ID of the currently authenticated user
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final vehicle = {'vin': vin, 'vehicleData': vehicleData};

      if (kDebugMode) {
        print('User ID: ${user.uid}');
      }
    } else {
      if (kDebugMode) {
        print('User is not authenticated.');
      }
    }

    if (userId != null && vin.isNotEmpty) {
      // Create a new vehicle object with the VIN and vehicle data
      final vehicle = {'vin': vin, 'vehicleData': vehicleData};

      // Add the new vehicle to the user's saved_vehicles subcollection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('saved_vehicles')
          .doc(vin)
          .set(vehicle);
      if (kDebugMode) {
        print('Vehicle added to saved_vehicles subcollection.');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vehicle added to My Vehicles.'),
        ),
      );
    } else {
      if (kDebugMode) {
        print('User is not authenticated or VIN is empty.');
      }
    }
  }
}
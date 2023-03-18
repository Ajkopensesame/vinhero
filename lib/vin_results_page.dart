import 'package:flutter/material.dart';

class VinResultsPage extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  VinResultsPage({required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIN Results'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildVehicleDetails(),
        ),
      ),
    );
  }

  List<Widget> _buildVehicleDetails() {
    List<String> keysToDisplay = [
      'VIN',
      'WorldManufacturerIdentifier',
      'Make',
      'Manufacturer Name',
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

    keysToDisplay.forEach((key) {
      if (vehicleData.containsKey(key) &&
          vehicleData[key] != null &&
          vehicleData[key].toString().isNotEmpty) {
        vehicleDetails.add(
          ListTile(
            title: Text(
              '$key:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(vehicleData[key].toString()),
            leading: Icon(Icons.directions_car),
          ),
        );
      }
    });

    return vehicleDetails;
  }
}

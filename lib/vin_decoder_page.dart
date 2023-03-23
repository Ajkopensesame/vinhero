import 'package:flutter/material.dart';
import 'package:vinhero/vin_results_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'barcode_scanner_page.dart';

class VinDecoderPage extends StatefulWidget {
  @override
  _VinDecoderPageState createState() => _VinDecoderPageState();
}

class _VinDecoderPageState extends State<VinDecoderPage> {
  TextEditingController _vinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VIN Decoder'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _vinController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: 'Enter VIN',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String vin = _vinController.text;
                await _handleScannedVin(vin);
              },
              child: Text('Submit VIN'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.all(12),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BarcodeScannerPage(onValidVinScanned: _handleScannedVin),
                  ),
                );
              },
              child: Text('Scan Barcode for VIN'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                textStyle: TextStyle(fontSize: 18),
                padding: EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isValidVin(String vin) {
    // Add VIN validation logic
    return vin.length == 17;
  }

  Future<void> _handleScannedVin(String vin) async {
    if (_isValidVin(vin)) {
      final vehicleData = await fetchVehicleInformation(vin);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VinResultsPage(vehicleData: vehicleData, vin: vin),
        ),
      );
    } else {
      // Show an error message if the VIN is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid VIN.'),
        ),
      );
    }
  }

  Future<Map<String, dynamic>> fetchVehicleInformation(String vin) async {
    final response = await http.get(
      Uri.parse(
          'https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/$vin?format=json'),
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      Map<String, dynamic> resultMap = {};

      for (var result in decodedData['Results']) {
        resultMap[result['Variable']] = result['Value'];
      }

      return resultMap;
    } else {
      throw Exception('Failed to load vehicle information');
    }
  }
}

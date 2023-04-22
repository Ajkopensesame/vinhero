import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FuelEconomyWidget extends StatefulWidget {
  final String make;
  final String model;
  final String year;

  FuelEconomyWidget({required this.make, required this.model, required this.year});

  @override
  _FuelEconomyWidgetState createState() => _FuelEconomyWidgetState();
}

class _FuelEconomyWidgetState extends State<FuelEconomyWidget> {
  Map<String, dynamic> fuelEconomy = {};

  @override
  void initState() {
    super.initState();
    _getFuelEconomy().then((value) => setState(() => fuelEconomy = value));
  }

  Future<Map<String, dynamic>> _getFuelEconomy() async {
    String fuelEconomyUrl =
        'https://www.fueleconomy.gov/ws/rest/ympg/shared/vehicles?make=${widget.make}&model=${widget.model}&year=${widget.year}';
    var fuelEconomyResponse = await http.get(Uri.parse(fuelEconomyUrl));
    if (fuelEconomyResponse.statusCode == 200) {
      return jsonDecode(fuelEconomyResponse.body);
    } else {
      throw Exception('Failed to load fuel economy data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (fuelEconomy.isEmpty) {
      return CircularProgressIndicator();
    } else {
      // You can customize the display of the fuel economy data as needed.
      return Text('Fuel economy: ${fuelEconomy.toString()}');
    }
  }
}

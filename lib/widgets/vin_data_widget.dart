import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VinDataWidget extends StatefulWidget {
  final String vin;

  const VinDataWidget({super.key, required this.vin});

  @override
  _VinDataWidgetState createState() => _VinDataWidgetState();
}

class _VinDataWidgetState extends State<VinDataWidget> {
  Map<String, dynamic> vinData = {};

  @override
  void initState() {
    super.initState();
    _getVinData().then((value) => setState(() => vinData = value));
  }

  Future<Map<String, dynamic>> _getVinData() async {
    String vinDataUrl =
        'https://vpic.nhtsa.dot.gov/api/vehicles/decodevin/${widget.vin}?format=json';
    var vinDataResponse = await http.get(Uri.parse(vinDataUrl));
    if (vinDataResponse.statusCode == 200) {
      return jsonDecode(vinDataResponse.body);
    } else {
      throw Exception('Failed to load VIN data');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (vinData.isEmpty) {
      return CircularProgressIndicator();
    } else {
      // You can customize the display of the VIN data as needed.
      return Text('VIN data: ${vinData.toString()}');
    }
  }
}

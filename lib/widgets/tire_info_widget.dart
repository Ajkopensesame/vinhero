import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TireInfoWidget extends StatefulWidget {
  final String tin;

  TireInfoWidget({required this.tin});

  @override
  _TireInfoWidgetState createState() => _TireInfoWidgetState();
}

class _TireInfoWidgetState extends State<TireInfoWidget> {
  Map<String, dynamic> tireInfo = {};

  @override
  void initState() {
    super.initState();
    _getTireInfo().then((value) => setState(() => tireInfo = value));
  }

  Future<Map<String, dynamic>> _getTireInfo() async {
    String tireInfoUrl =
        'https://vpic.nhtsa.dot.gov/api/vehicles/DecodeTire?TireId=${widget.tin}&format=json';
    var tireInfoResponse = await http.get(Uri.parse(tireInfoUrl));
    if (tireInfoResponse.statusCode == 200) {
      return jsonDecode(tireInfoResponse.body);
    } else {
      throw Exception('Failed to load tire information');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tireInfo.isEmpty) {
      return CircularProgressIndicator();
    } else {
      // You can customize the display of the tire information as needed.
      return Text('Tire information: ${tireInfo.toString()}');
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchVehicleInformation(String vin) async {
  final response = await http.get(
    Uri.parse('https://vpic.nhtsa.dot.gov/api/vehicles/DecodeVin/$vin?format=json'),
  );

  if (response.statusCode == 200) {
    final decodedData = jsonDecode(response.body);
    return decodedData;
  } else {
    throw Exception('Failed to load vehicle information');
  }
}

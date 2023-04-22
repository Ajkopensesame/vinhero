import 'dart:convert';
import 'package:http/http.dart' as http;

class NhtsaService {
  Future<List<dynamic>> getRecalls(String make, String model, String year) async {
    final response = await http.get(Uri.parse('https://one.nhtsa.gov/webapi/api/Recalls/vehicle/modelyear/$year/make/$make/model/$model?format=json'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data['Results'];
    } else {
      throw Exception('Failed to fetch recalls data');
    }
  }
}

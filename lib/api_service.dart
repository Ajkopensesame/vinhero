import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _apiKey = 'your_unsplash_api_key';
  static const String _baseUrl = 'https://api.unsplash.com';

  Future<String> fetchImageUrl(String searchQuery) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/photos/random?query=$searchQuery&client_id=$_apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['urls']['small'];
    } else {
      throw Exception('Failed to fetch image');
    }
  }
}

import 'dart:convert';
import 'package:flutter/services.dart';

class ErrorCodeService {
  Future<List<dynamic>> getErrorCodes() async {
    final String jsonString = await rootBundle.loadString('assets/obd2_codes.json');
    return json.decode(jsonString);
  }
}

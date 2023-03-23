import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vinhero/obd2_page.dart';
import 'package:vinhero/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vinhero/base_page.dart';
import 'package:vinhero/sign_in_page.dart';
import 'package:vinhero/sign_up_page.dart';
import 'package:vinhero/vin_decoder_page.dart';
import 'package:vinhero/barcode_scanner_page.dart';
import 'package:vinhero/vin_results_page.dart';
import 'authentication_wrapper.dart';
import 'home_page.dart';
import 'package:vinhero/parts_page.dart';
import 'package:vinhero/logbook_page.dart';
import 'package:vinhero/fixed_page.dart';
import 'package:vinhero/quotes_page.dart';
import 'package:vinhero/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VinHeroApp(vin: '',));
}

class VinHeroApp extends StatelessWidget {
  final String vin;

  VinHeroApp({required this.vin});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vin Hero',
      theme: ThemeData(
        primaryColor: Color(0xFF08a24a),
        accentColor: Color(0xFF0ce769),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF08a24a),
          secondary: Color(0xFF0ce769),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(0xFF08a24a),
          selectionHandleColor: Color(0xFF08a24a),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF08a24a), width: 1.0),
          ),
        ),
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BasePage(child: AuthenticationWrapper()),
        '/sign_in': (context) => BasePage(child: SignInPage()),
        '/sign_up': (context) => BasePage(child: SignUpPage()),
        '/home': (context) => BasePage(child: HomePage()),
        '/parts_page': (context) => BasePage(child: PartsPage(vin: vin)),
        '/logbook_page': (context) => BasePage(child: (LogbookPage(vin: vin))),
        '/fixed_page': (context) => BasePage(child: FixedPage()),
        '/quotes_page': (context) => BasePage(child: QuotesPage()),
        '/chat_page': (context) => BasePage(child: ChatPage()),

        '/obd2_page': (context) => BasePage(child: OBD2Page()),
        '/vin_decoder': (context) => BasePage(child: VinDecoderPage()),
        '/profile_page': (context) => BasePage(child: ProfilePage()),
        '/barcode_scanner': (context) => BasePage(child: BarcodeScannerPage(
          onValidVinScanned: (vin) async {
            final vehicleData = await fetchVehicleInformation(vin);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VinResultsPage(vehicleData: vehicleData, vin: '',),
              ),
            );
          },
        )
        ),
      },

    );
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
    } else{
      throw Exception('Failed to load vehicle information');
    }
  }
}
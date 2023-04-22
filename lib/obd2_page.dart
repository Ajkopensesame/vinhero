import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

class OBD2Page extends StatefulWidget {
  @override
  _OBD2PageState createState() => _OBD2PageState();
}

class _OBD2PageState extends State<OBD2Page> {
  bool _isConnecting = false;
  bool _isConnected = false;
  final _ble = FlutterReactiveBle();

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<String> _fetchRandomCarImageUrl() async {
    final response = await http.get(Uri.parse('https://source.unsplash.com/800x600/?car'));

    if (response.statusCode == 200) {
      return response.request!.url.toString();
    } else {
      throw Exception('Failed to load random car image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OBD2'),
      ),
      body: FutureBuilder<String>(
        future: _fetchRandomCarImageUrl(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (!_isConnecting && !_isConnected)
                          ElevatedButton(
                            onPressed: _startConnecting,
                            child: Text('Connect to Bluetooth'),
                          ),
                        if (_isConnecting)
                          CircularProgressIndicator(),
                        if (_isConnected)
                          Text('Bluetooth connected!'),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _requestPermissions() async {
    if (await Permission.location
        .request()
        .isGranted) {
      print("Location permission granted");
    } else {
      print("Location permission denied");
    }
  }

  void _startConnecting() async {
    setState(() {
      _isConnecting = true;
    });

    final status = await _ble.statusStream.first;

    if (status == BleStatus.ready) {
      StreamSubscription<DiscoveredDevice>? scanSubscription;

      scanSubscription =
          _ble.scanForDevices(withServices: []).listen((scanResult) async {
            if (scanResult.name.contains("OBDII")) {
              // You can replace "OBDII" with the specific name of your ELM327 Bluetooth adapter
              print("Found device: ${scanResult.name}");
              if (scanSubscription != null) {
                await scanSubscription.cancel();
              }

              final connection = _ble.connectToDevice(id: scanResult.id);

              connection.listen((connectionState) async {
                if (connectionState.connectionState ==
                    DeviceConnectionState.connected) {
                  setState(() {
                    _isConnecting = false;
                    _isConnected = true;
                  });

                  // Read data from your ELM327 Bluetooth adapter here
                  // You can subscribe to a characteristic or send commands depending on your use case
                } else if (connectionState.connectionState ==
                    DeviceConnectionState.disconnected) {
                  setState(() {
                    _isConnecting = false;
                    _isConnected = false;
                  });
                }
              });

              return; // Replacing 'break' with 'return' to exit the listener's callback
            }
          });
    } else {
      setState(() {
        _isConnecting = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showBluetoothDialog(context);
      });
    }
  }

  void _showBluetoothDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bluetooth is not enabled'),
          content: const Text('Please enable Bluetooth to connect to the OBD2 device.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

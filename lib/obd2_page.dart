import 'package:flutter/material.dart';
import 'package:vinhero/obd2_page.dart';
class OBD2Page extends StatefulWidget {
  @override
  _OBD2PageState createState() => _OBD2PageState();
}

class _OBD2PageState extends State<OBD2Page> {
  bool _isConnecting = false;
  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OBD2'),
      ),
      body: Center(
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
    );
  }

  void _startConnecting() {
    setState(() {
      _isConnecting = true;
    });
    // TODO: Implement your Bluetooth connection logic here
    // You can use a package like flutter_bluetooth_serial or flutter_blue
    // Once the connection is established, set _isConnecting to false and _isConnected to true
  }
}

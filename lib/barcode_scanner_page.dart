import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class BarcodeScannerPage extends StatefulWidget {
  final Function(String) onValidVinScanned;

  BarcodeScannerPage({required this.onValidVinScanned});

  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode for VIN'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: _qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Scanned VIN: ${_result ?? "No VIN scanned"}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      if (_isValidVin(scanData.code)) {
        widget.onValidVinScanned(scanData.code!);
        Navigator.pop(context);
      } else {
        // Show an error message if the scanned VIN is not valid
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please scan a valid VIN.'),
          ),
        );
        controller.resumeCamera();
      }
    });
  }

  bool _isValidVin(String? vin) {
    if (vin == null) {
      return false;
    }
    return vin.length == 17;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

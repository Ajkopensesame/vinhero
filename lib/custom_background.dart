import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomBackground extends StatefulWidget {
  final Widget child;
  final String make;
  final String model;
  final String year;

  CustomBackground({
    Key? key,
    required this.child,
    required this.make,
    required this.model,
    required this.year, required String imageUrl,
  }) : super(key: key);

  @override
  _CustomBackgroundState createState() => _CustomBackgroundState();
}

class _CustomBackgroundState extends State<CustomBackground> {
  String? _backgroundImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchBackgroundImage();
  }

  Future<void> _fetchBackgroundImage() async {
    final query = '${widget.make} ${widget.model} ${widget.year}';
    final url = 'https://api.unsplash.com/search/photos?query=$query&client_id=<4FEdNfDrLQa_Xlwdd5cGjvBBbUaA55XqVtQrLDX7bgI>';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final imageUrl = data['results'][0]['urls']['regular'];
      setState(() {
        _backgroundImageUrl = imageUrl;
      });
    } else {
      print('Failed to load background image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: _backgroundImageUrl != null
            ? DecorationImage(
          image: NetworkImage(_backgroundImageUrl!),
          fit: BoxFit.cover,
        )
            : null,
      ),
      child: widget.child,
    );
  }
}

import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final Widget child;

  BasePage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vin Hero'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/vin_hero.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      ),
    );
  }
}

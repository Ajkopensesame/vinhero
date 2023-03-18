import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class MatrixRain extends StatefulWidget {
  @override
  _MatrixRainState createState() => _MatrixRainState();
}

class _MatrixRainState extends State<MatrixRain> with SingleTickerProviderStateMixin {
  final _random = Random();
  late AnimationController _controller;
  late List<Stream<int>> _streams;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();

    _streams = List.generate(
      100,
          (index) => Stream<int>.periodic(
        Duration(milliseconds: 50 + _random.nextInt(100)),
            (count) => _random.nextInt(9),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (final stream in _streams)
          Positioned(
            left: _random.nextDouble() * MediaQuery.of(context).size.width,
            top: _random.nextDouble() * MediaQuery.of(context).size.height,
            child: StreamBuilder<int>(
              stream: stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox.shrink();
                return Text(
                  snapshot.data.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.lerp(Colors.green, Colors.white, _random.nextDouble() * 0.3),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

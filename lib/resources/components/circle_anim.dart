import 'dart:math';

import 'package:flutter/material.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 3.0)).clamp(0.0, 1.0);
    Color greenColor =  Color.fromRGBO(14, 204, 65, opacity);
    //Color redColor =  Color.fromRGBO(201, 22, 22, opacity);


    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 5);

    final Paint paint =  Paint()..color = greenColor;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect =  Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 4; wave > 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}
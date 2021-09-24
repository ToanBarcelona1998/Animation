import 'package:flutter/material.dart';
import 'dart:math';
class WavePainter extends CustomPainter {
  Animation<double> ?waveAnimation;
  Color ?waveColor;
  WavePainter({this.waveAnimation, this.waveColor});
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    for (double i = 0.0; i < size.width; i++) {
      path.lineTo(i, cos((i / size.width * 2 * pi) + (waveAnimation!.value * 2 * pi)) * 8);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    Paint wavePaint = Paint()..color = waveColor!;
    canvas.drawPath(path, wavePaint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
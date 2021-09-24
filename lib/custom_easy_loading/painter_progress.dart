import 'dart:math';
import 'package:custom_loading_animation/theme.dart';
import 'package:flutter/material.dart';

class PainterProgress extends CustomPainter {
  Color ?lineColor;
  Color ?completeColor;
  double ?completePercent;
  double ?strokeWidth;

  PainterProgress({this.lineColor,this.completeColor=AppTheme.colorYellowHighLight,this.completePercent=0,this.strokeWidth=1});

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor??Colors.grey
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!;
    Paint complete = new Paint()
      ..color = completeColor!
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent! / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

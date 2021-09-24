import 'package:flutter/material.dart';
class ProfileCard extends CustomPainter {
  final circleWidth;

  ProfileCard({this.circleWidth});

  @override
  void paint(Canvas canvas, Size size) {
    var fillPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var wavePaint = Paint()
      ..color = Colors.blue[900]!.withOpacity(0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    Path path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(size.width * 1/4, size.height * 1/4, size.width / 2, size.height / 2, size.width, 0);
    path.lineTo(size.width, size.height);


    var holePaint = Paint()
      ..color = Colors.lightBlue
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;
    Offset holeOffset = Offset(size.width / 2, size.height - circleWidth / 6);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), fillPaint);
    canvas.drawPath(path, wavePaint );
    canvas.drawCircle(holeOffset, circleWidth, holePaint);
  }

  @override
  bool shouldRepaint(ProfileCard oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(ProfileCard oldDelegate) => false;
}
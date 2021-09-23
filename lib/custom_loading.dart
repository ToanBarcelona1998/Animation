import 'package:custom_loading_animation/theme.dart';
import 'package:flutter/material.dart';

class CustomCircle extends CustomPainter {
  static const double _widthRectangle = 70;
  static const double _heightRectangle = 60;


  static const double _strokeWidthPainter = 1;

  static double _radiusCircle = 3;

  static const double _paddingCirlce=10;

  List<double> ?dy;


  CustomCircle({this.dy});
  //Color của circle
  List<Color> _colorCircle = [AppTheme.colorTextQuest, AppTheme.colorYellowHighLight, AppTheme.backgroundButtonWarring];

  //Color Rectangle
  Color _colorRectangle = AppTheme.deactivatedText;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintRectangle = Paint()
      ..style = PaintingStyle.fill
      ..color = _colorRectangle.withOpacity(0.3)
      ..strokeWidth = _strokeWidthPainter;
    //
    Path pathRectangle = Path()
      ..moveTo((size.width / 2) - (_widthRectangle / 2), (size.height / 2) - (_heightRectangle / 2))
      ..lineTo((size.width / 2) - (_widthRectangle / 2), (size.height / 2) + (_heightRectangle / 2))
      ..lineTo((size.width / 2) + (_widthRectangle / 2), (size.height / 2) + (_heightRectangle / 2))
      ..lineTo((size.width / 2) + (_widthRectangle / 2), (size.height / 2) - (_heightRectangle / 2))
      ..close();
    //Paint Rectangle
   // canvas.drawPath(pathRectangle, paintRectangle);

    RRect rrect=RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(size.width/2,size.height/2), width: _widthRectangle, height: _heightRectangle-15), Radius.circular(10));
    canvas.drawRRect(rrect, paintRectangle);

    double dx=(size.width/2)-(_widthRectangle/2) + _paddingCirlce;
    double equidistant= 0.0;
    for(int i=0;i<_colorCircle.length;i++){
      dx=dx+equidistant+(i+1)*_radiusCircle;
      equidistant=(_widthRectangle - 2 * _paddingCirlce - 6 * _radiusCircle)/3 +_radiusCircle/3;
      Paint paintCircle=Paint()..style=PaintingStyle.fill..color=_colorCircle[i]..strokeWidth=_strokeWidthPainter;
      canvas.drawCircle(Offset(dx,dy![i]), _radiusCircle, paintCircle);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

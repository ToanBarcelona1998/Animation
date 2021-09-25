import 'dart:math';

import 'package:flutter/material.dart';

class CustomChartPerfect extends CustomPainter {
  final List<int> listData;

  static const double _scaleTitle = 1.2;
  static const double _radiusCirclePoint = 2;
  static const _strokeWidthgraph = 2;
  static const _strokeWidthLine = 1;
  static const _numberLine = 5;
  static const double _paddingChart = 10;
  static const double _scaleData = 1;
  static const double _radiusRectagle = 5;

  late double _marginTop;
  late double _marginLeft;
  late double _marginRight;
  late double _marginBottom;

  CustomChartPerfect({required this.listData}) {
    _marginTop = createText(message: "Tình hình Covid tại Việt Nam", scale: _scaleTitle).height + _paddingChart;
    _marginLeft = createText(message: getMax().toString(), scale: _scaleData).width + _paddingChart;
    _marginRight = _paddingChart;

    _marginBottom = createText(message: getMax().toString(), scale: _scaleData).height + _paddingChart;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawTile(canvas, size);
  }

  void drawLines(Canvas canvas, Size size, Paint paintLine) {
    canvas.drawLine(Offset(_marginLeft, size.height - _marginBottom), Offset(_marginLeft, _marginTop), paintLine);
    canvas.drawLine(Offset(_marginLeft, size.height - _marginBottom),
        Offset(size.width - _marginRight, size.height - _marginTop), paintLine);

    double upTo = (size.height - _marginBottom - _marginTop) / 4;
    for (int i = 0; i < _numberLine - 1; i++) {
      canvas.drawLine(Offset(_marginLeft, size.height - _marginBottom - upTo),
          Offset(size.width - _marginRight, size.height - upTo), paintLine);
    }
  }
  


  void drawMusty(Canvas canvas, Size size) {
    double upTo = (size.height - _marginBottom - _marginTop) / 5;
    for (int i = 1; i <= 5; i++) {
      TextPainter textPainter = createText(message: (this.assignData() / i).toString(), scale: _scaleData);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(_marginLeft - createText(message: getMax().toString(), scale: _scaleData).width,
            (size.height - _marginBottom) + upTo),
      );
    }
    double horizontal = (size.width - _marginLeft - _marginRight) / 11;
    for (int i = 1; i <= 10; i++) {
      TextPainter textPainter = createText(message: (this.assignData() / i).toString(), scale: _scaleData);
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
            _marginLeft, size.width - _marginRight + createText(message: 0.toString(), scale: _scaleData).width + horizontal),
      );
    }
  }

  //Create title
  void drawTile(Canvas canvas, Size size) {
    TextPainter tp = createText(
      message: "Tình hình Covid tại Việt Nam",
      scale: _scaleTitle,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, 0.0));
  }

  //Tạo ra chú thích
  void createCategory(Canvas canvas, Size size, Paint paintCategory, List<String> listCategory) {
    double padding = (size.width -
            2 * _paddingChart -
            6 * _radiusRectagle -
            createText(message: listCategory[0], scale: _scaleData).width -
            createText(message: listCategory[1], scale: _scaleData).width -
            createText(message: listCategory[2], scale: _scaleData).width) /
        listCategory.length;
    double startDx = 0.0;
    for (int i = 0; i < listCategory.length; i++) {
      startDx = startDx +
          _paddingChart +
          2 * _radiusRectagle +
          createText(message: listCategory[i], scale: _scaleData).width +
          padding;
      canvas.drawRect(
          Rect.fromCircle(center: Offset(startDx, size.height - 2 * _paddingChart), radius: _radiusRectagle), paintCategory);
    }
  }

  //Tạo ra 1 thằng text
  TextPainter createText({required String message, required double scale, TextStyle? style}) {
    TextSpan span = TextSpan(text: message, style: style);
    TextPainter tp = TextPainter(
        text: span, textScaleFactor: scale, textAlign: TextAlign.start, maxLines: 3, textDirection: TextDirection.ltr);
    return tp;
  }

  int getMax() {
    int max = 0;
    for (var value in this.listData) {
      if (value > max) {
        max = value;
      }
    }
    return max;
  }

  int assignData() {
    return 250;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

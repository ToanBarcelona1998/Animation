import 'dart:math';

import 'package:flutter/material.dart';

import 'line_data.dart';

class CustomChart extends CustomPainter {
  final String title;
  final List<LineData> lineData;
  List<String>? categories;
  final double? percentage;

  late double marginLeft;
  late double marginTop;
  late double marginBottom;
  late double marginRight;
  late double maxValue = 250;
  static double emptySpace = 5;

  // title
  static double titleTextScale = 1.5;

  // axis
  static double axisWidth = 2;
  static double axisTextScale = 1;

  // legend
  static double legendSquareWidth = 10;
  static double legendTextScale = 1;

  CustomChart({this.percentage, required this.lineData, this.title = "Tình hình covid Việt Nam"}) {
    marginLeft = createText(maxValue.toString(), 1).width + emptySpace;
    marginTop = createText(title, titleTextScale).height + emptySpace;
    marginBottom = createText(1.toString(), axisTextScale).height * 2 + emptySpace;
    marginRight = 0;

    lineData.forEach((element) {
      double width = createText(element.category!, legendTextScale).width + legendSquareWidth + emptySpace;
      if (width > marginRight) {
        marginRight = width;
      }
    });
    categories = lineData[0].data!.keys.toList();
  }

  @override
  void paint(Canvas canvas, Size size) {

    // two main lines
    Paint axis = Paint()
      ..strokeWidth = axisWidth
      ..color = Colors.grey;

    // horizontal lines through the chart
    Paint axisLight = Paint()
      ..strokeWidth = axisWidth
      ..color = Colors.grey.withOpacity(0.5);

    drawTitle(canvas, size);
    drawAxes(canvas, size, axis, axisLight);
    drawLegend(canvas, size);
    drawLines(size, canvas);
  }

  // paint tiêu đề
  void drawTitle(Canvas canvas, Size size) {
    TextPainter tp = createText(title, titleTextScale);
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, 0.0));
  }

  // paint các dòng dữ liệu
  void drawLines(Size size, Canvas canvas) {
    var index = 0;
    lineData.forEach((element) {
      var percentageCorrected = lineData.length * min(percentage! - index * 100 / (lineData.length), 100 / (lineData.length));

      var points = element.data!.entries.toList();
      for (int i = 0; i < (points.length - 1); i++) {
        var percentageOfLine =
            (points.length - 1) * min(percentageCorrected - i * 100 / (points.length - 1), 100 / (points.length - 1));
        if (percentageOfLine > 0) {
          var firstPoint = entryToPoint(points[i], size);
          var goalPoint = entryToPoint(points[i + 1], size);
          var nextPoint = new Offset(percentageOfLine / 100 * (goalPoint.dx - firstPoint.dx) + firstPoint.dx,
              percentageOfLine / 100 * (goalPoint.dy - firstPoint.dy) + firstPoint.dy);
          canvas.drawLine(entryToPoint(points[i], size), nextPoint, getLinePaint(element));
          canvas.drawCircle(firstPoint, 5, getLineDataColorPaint(element));
        }
      }
      if (percentageCorrected >= 99.9) {
        canvas.drawCircle(entryToPoint(points[points.length - 1], size), 5, getLineDataColorPaint(element));
      }
      index++;
    });
  }

  // paint thằng chú thích
  void drawLegend(Canvas canvas, Size size) {
    double i = 0;
    lineData.forEach((element) {
      TextPainter tp = createText(element.category!, legendTextScale);
      tp.paint(
          canvas,
          new Offset(
              size.width - marginRight + legendSquareWidth + 2 * emptySpace, (i * tp.height + marginTop - tp.height / 2)));
      var center = new Offset(size.width - marginRight + legendSquareWidth + emptySpace, (i * tp.height + marginTop));
      canvas.drawRect(
          Rect.fromCenter(center: center, width: legendSquareWidth, height: legendSquareWidth), getLineDataColorPaint(element));
      i++;
    });
  }

  Paint getLineDataColorPaint(LineData lineData) {
    return new Paint()
      ..strokeWidth = 4
      ..color = lineData.color!;
  }

  Paint getLinePaint(LineData lineData) {
    return new Paint()
      ..strokeWidth = 4
      ..color = lineData.color!.withOpacity(0.5);
  }

  void drawAxes(
    Canvas canvas,
    Size size,
    Paint axis,
    Paint axisLight,
  ) {
    // vẽ line trục ngang
    canvas.drawLine(
      Offset(marginLeft, size.height - marginTop),
      Offset(size.width - marginRight, size.height - marginTop),
      axis,
    );
    // Vẽ trục dọc
    canvas.drawLine(
      Offset(marginLeft, size.height - marginTop),
      Offset(marginLeft, marginTop),
      axis,
    );
    // Vẽ thằng chữ nhật chú giải
    addCategoriesAsTextToHorizontalAxis(size, canvas);
    // Vẽ 5 giá trị trên trục dọc và vẽ trục ngang
    addHorizontalLinesAndSizes(size, canvas, axisLight);
  }

  //Paint line theo chiều ngang
  void addHorizontalLinesAndSizes(Size size, Canvas canvas, Paint axisLight) {
    for (int i = 1; i <= 5; i++) {
      double y = chartHeight(size) - chartHeight(size) * (i / 5) + marginTop;
      TextPainter tp = createText((maxValue / 5 * i).round().toString(), 1);
      tp.paint(canvas, new Offset(marginLeft - tp.width - emptySpace, y - emptySpace));

      canvas.drawLine(
        Offset(marginLeft, y),
        Offset(size.width - marginRight, y),
        axisLight,
      );
    }
  }


  //Paint text bên phải chú giải
  void addCategoriesAsTextToHorizontalAxis(Size size, Canvas canvas) {
    categories!.forEach((entry) {
      TextPainter tp = createText(entry, 1);
      var x = chartWidth(size) * categories!.indexOf(entry) / (categories!.length - 1) + marginLeft - tp.width / 2;
      tp.paint(canvas, new Offset(x, chartHeight(size) + marginTop + tp.height / 2));
    });
  }

  //tính toán điểm bắt đầu
  Offset entryToPoint(MapEntry<String, double> entry, Size size) {
    double x = chartWidth(size) * categories!.indexOf(entry.key) / (categories!.length - 1) + marginLeft;
    double y = chartHeight(size) - chartHeight(size) * (entry.value / maxValue) + marginTop;
    return new Offset(x, y);
  }

  //lấy ra height của device
  double chartHeight(Size size) => size.height - marginTop - marginBottom;

  //lấy ra width của device
  double chartWidth(Size size) => size.width - marginRight - marginLeft;

  // create text
  TextPainter createText(String title, double scale) {
    TextSpan textSpan =
        TextSpan(text: title, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700, fontSize: 14));
    TextPainter tp =
        TextPainter(text: textSpan, textScaleFactor: scale, textAlign: TextAlign.start, textDirection: TextDirection.ltr);
    tp.layout();
    return tp;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

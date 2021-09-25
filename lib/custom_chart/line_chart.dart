import 'package:custom_loading_animation/custom_chart/custom_chart.dart';
import 'package:custom_loading_animation/custom_chart/line_data.dart';
import 'package:flutter/material.dart';

class LineChart extends StatelessWidget {
  LineChart({Key? key}) : super(key: key);
  static List<double> hamilton = [0, 12, 0, 0, 25, 19, 25, 25, 7, 0, 15, 8];
  static List<double> bottas = [0, 25, 18, 15, 0, 15, 16, 18, 10, 18, 26, 0];
  static List<double> max = [0, 0, 15, 18, 19, 25, 18, 15, 0, 0, 18, 19];

  final List<LineData> listData = [
    LineData("Hamiton", Colors.teal[700]!, hamilton),
    LineData("Bottas", Colors.teal[300]!, bottas),
    LineData("Verstappen", Colors.blue[900]!, max)
  ];

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 100.0),
      duration: Duration(seconds: 8),
      builder: (context, value, child) {
        return CustomPaint(
          painter: CustomChart(lineData: listData, percentage: value),
          child: Container(
            width: double.infinity,
            height: 340,
          ),
        );
      },
    );
  }
}

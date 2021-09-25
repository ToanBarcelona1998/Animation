import 'package:flutter/material.dart';

class LineData {
  Map<String, double> ?data;
  String ?category;
  Color? color;

  LineData(String category, Color color, List<double> values){
    this.color=color;
    this.category=category;
    this.data=this.createCumulativeData(values);
  }

  Map<String, double> createCumulativeData(List<double> values) {
    Map<String, double> map = Map();
    int c = 0;
    double sum = 0;
    for (double value in values) {
      sum += value;
      map.putIfAbsent(c.toString(), () => sum);
      c++;
    }
    return map;
  }
}

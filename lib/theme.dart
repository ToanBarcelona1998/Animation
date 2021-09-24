import 'package:flutter/material.dart';
class AppTheme{
  static const Color colorTextQuest=Color(0xff1678cc);
  static const Color colorYellowHighLight=Color(0xffc1923a);
  static const Color backgroundButtonWarring=Color(0xffdd0000);
  static const Color deactivatedText=Color(0xFF767676);
  static const Color colorLoading =Color.fromARGB(255,33, 33, 33);
  static const Color colorWhite = Colors.white;

  ThemeData _darkTheme(){
    return ThemeData();
  }
  ThemeData _lightTheme(){
    return ThemeData();
  }

  ThemeData get darkTheme{
    return _darkTheme();
  }

  ThemeData get lightTheme{
    return _lightTheme();
  }
}
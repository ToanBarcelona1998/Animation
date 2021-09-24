import 'dart:async';

import 'package:flutter/material.dart';

class ButtonLoading extends StatefulWidget {
  const ButtonLoading({Key? key}) : super(key: key);

  @override
  _ButtonLoadingState createState() => _ButtonLoadingState();
}

class _ButtonLoadingState extends State<ButtonLoading> with SingleTickerProviderStateMixin {
  int _state = 0;

  GlobalKey _buttonKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();
  Animation? _animation;
  AnimationController? _controller;

  double initWidth = 0.0;
  double _width = double.maxFinite;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {
          _width = initWidth - ((initWidth - 48) * _animation?.value);
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: PhysicalModel(
          color: Colors.lightGreen,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: _width,
            key: _buttonKey,
            height: 48,
            child: ElevatedButton(
                onPressed: () {
                  if (_state == 0) {
                    animateButton();
                  }
                },
                child: childWidget()),
          ),
        ),
      ),
    );
  }

  void animateButton() {
    final RenderBox renderBox=_buttonKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      initWidth = renderBox.size.width;
    });
    print(initWidth);

    _controller?.forward();
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
      });
    });
  }

  Widget childWidget() {
    if (_state == 0) {
      return Text("Click here");
    } else if (_state == 1) {
      return CircularProgressIndicator(
        strokeWidth: 0.7,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}

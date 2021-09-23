import 'package:custom_loading_animation/custom_loading.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key ?key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  AnimationController ?_controller;
  Animation ?_animation;

  double _startValue=0.0;
  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _animation=Tween(begin: _startValue, end: 0.0).animate(CurvedAnimation(parent: _controller!, curve: Curves.bounceIn))..addListener(loadAnimation);
  }
  @override
  void dispose() {
    _animation?.removeListener(loadAnimation);
    _controller?.dispose();
    super.dispose();
  }
  void loadAnimation(){
    _startValue=_animation?.value;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: CustomPaint(
          painter: CustomCircle(dy: _startValue),
          child: Container(
            height: 150,
            width: size.width,
          ),
        )
      ),
    );
  }
}



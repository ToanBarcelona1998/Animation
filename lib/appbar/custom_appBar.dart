import 'dart:ui';
import 'package:flutter/material.dart';

class AnimatedAppBar extends StatelessWidget {
  final AnimationController colorAnimationController;
  final Animation colorTween, homeTween, workOutTween, iconTween, drawerTween;
  final Function() onPressed;

  const AnimatedAppBar({
    required this.colorAnimationController,
    required this.onPressed,
    required this.colorTween,
    required this.homeTween,
    required this.iconTween,
    required this.drawerTween,
    required this.workOutTween,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: AnimatedBuilder(
        animation: colorAnimationController,
        builder: (context, child) => AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.dehaze,
              color: drawerTween.value,
            ),
            onPressed: onPressed,
          ),
          backgroundColor: colorTween.value,
          elevation: 0,
          titleSpacing: 0.0,
          title: Row(
            children:[
              Text(
                "Hello  ",
                style: TextStyle(color: homeTween.value, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
              ),
              Text(
                'Toan',
                style: TextStyle(color: workOutTween.value, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
              ),
            ],
          ),
          actions: [
            Icon(
              Icons.notifications,
              color: iconTween.value,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage('https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController colorController;

  // late AnimationController textController;

  late Animation _colorTween, _homeTween, _workOutTween, _iconTween, _drawerTween;

  @override
  void initState() {
    colorController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white).animate(colorController);
    _iconTween = ColorTween(begin: Colors.white, end: Colors.lightBlue.withOpacity(0.5)).animate(colorController);
    _drawerTween = ColorTween(begin: Colors.white, end: Colors.black).animate(colorController);
    _homeTween = ColorTween(begin: Colors.white, end: Colors.blue).animate(colorController);
    _workOutTween = ColorTween(begin: Colors.white, end: Colors.blue).animate(colorController);
    // textController = AnimationController(vsync: this, duration: Duration(seconds: 0));

    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  bool scrollListener(ScrollNotification scrollInfo) {
    bool scroll = false;
    if (scrollInfo.metrics.axis == Axis.vertical) {
      colorController.animateTo(scrollInfo.metrics.pixels / 80);

      return scroll = true;
    }
    return scroll;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(),
      backgroundColor: Color(0xFFEEEEEE),
      body: NotificationListener<ScrollNotification>(
        onNotification: scrollListener,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.cyan,
                      height: 200,
                    ),
                    Container(
                      color: Colors.red,
                      height: 600,
                    ),
                  ],
                ),
              ),
              AnimatedAppBar(
                drawerTween: _drawerTween,
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                colorAnimationController: colorController,
                colorTween: _colorTween,
                homeTween: _homeTween,
                iconTween: _iconTween,
                workOutTween: _workOutTween,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:custom_loading_animation/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'appbar/custom_appBar.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const MethodChannel channel = MethodChannel("save_file");
const MethodChannel platform = MethodChannel('dexterx.dev/flutter_local_notifications_example');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (
        int id,
        String? title,
        String? body,
        String? payload,
      ) async {});
  const MacOSInitializationSettings initializationSettingsMacOS = MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MyHomePage(
      //body: SaveFile(url: "https://binhminhdigital.com/StoreData/PageData/3429/Tim-hieu-ve-ban-quyen-hinh-anh%20(3).jpg",),
      //Center(child: LineChart()),
      // Center(
      //   child: WaveContainer(height: 100, width: size.width),
      // ),
      // EasyLoading(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () async {
      //             EasyLoading.show(type: LoadingType.progress, message: "Loading");
      //             double i = 0.0;
      //             while (i < 100.0) {
      //               i = i + 10.0;
      //               await Future.delayed(Duration(milliseconds: 400));
      //               EasyLoading.updateProgress(progress: i, message: "${i.toInt()} %");
      //               if(i==80.0){
      //                 EasyLoading.dismiss();
      //                 await EasyLoading.showErrorAndAutoDismiss(message: "Có lỗi xảy ra trong quá trình xử lý");
      //               }
      //             }
      //             EasyLoading.dismiss();
      //             await EasyLoading.showSuccessAndAutoDismiss(message: "Hoàn thành");
      //           },
      //           child: Text("Show"),
      //         ),
      //         ElevatedButton(
      //           onPressed: () async {
      //             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      //           },
      //           child: Text("Hide"),
      //         ),
      //       ],
      //     ),
      //   ),
      //   duration: Duration(milliseconds: 2600),
      // ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController? _controller;
  AnimationController? _controller1;
  AnimationController? _controller2;
  Animation? _animation;
  Animation? _animation1;
  Animation? _animation2;
  List<double>? _listStartValue;
  double _heightContainer = 150;

  int count = 0;
  int count2 = 0;

  @override
  void initState() {
    super.initState();

    _listStartValue = [_heightContainer / 2 + 10, _heightContainer / 2 + 10, _heightContainer / 2 + 10];

    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 900))
      ..addListener(() async {
        _controller!.reverseDuration = Duration(milliseconds: 1000);
        count++;
        if (_controller!.status == AnimationStatus.forward && count == 1) {
          _controller1!.forward();
        }
        if (_controller!.status == AnimationStatus.completed) {
          _controller!.reverse();
        }
        if (_controller!.status == AnimationStatus.dismissed) {
          _controller!.forward();
        }
      });
    _controller1 = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
      ..addListener(() {
        _controller1!.reverseDuration = Duration(milliseconds: 900);
        count2++;
        if (_controller1!.status == AnimationStatus.forward && count2 == 1) {
          _controller2!.forward();
        }
        if (_controller1!.status == AnimationStatus.completed) {
          _controller1!.reverse();
        }
        if (_controller1!.status == AnimationStatus.dismissed) {
          _controller1!.forward();
        }
      });
    _controller2 = AnimationController(vsync: this, duration: Duration(milliseconds: 1100))
      ..addListener(() {
        _controller2!.reverseDuration = Duration(milliseconds: 800);
        if (_controller2!.status == AnimationStatus.completed) {
          _controller2!.reverse();
        }
        if (_controller2!.status == AnimationStatus.dismissed) {
          _controller2!.forward();
        }
      });

    _animation = Tween(begin: _listStartValue![0], end: _heightContainer / 2 - 10)
        .animate(CurvedAnimation(parent: _controller!, curve: Curves.decelerate))
          ..addListener(loadAnimation);
    _animation1 = Tween(begin: _listStartValue![1], end: _heightContainer / 2 - 10)
        .animate(CurvedAnimation(parent: _controller1!, curve: Curves.decelerate))
          ..addListener(loadAnimation1);
    _animation2 = Tween(begin: _listStartValue![2], end: _heightContainer / 2 - 10)
        .animate(CurvedAnimation(parent: _controller2!, curve: Curves.decelerate))
          ..addListener(loadAnimation2);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void loadAnimation() {
    _listStartValue![0] = _animation!.value;
    setState(() {});
  }

  void loadAnimation1() {
    _listStartValue![1] = _animation1!.value;
    setState(() {});
  }

  void loadAnimation2() {
    _listStartValue![2] = _animation2!.value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffbfb599),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _controller!.forward();
        },
        child: Icon(Icons.add),
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            child: Text(
              "Hello! I Come From Viet Nam .Welcome to my project. Custom Loading",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: size.height / 2 - _heightContainer / 2,
            child: CustomPaint(
              painter: CustomCircle(dy: _listStartValue),
              child: Container(
                height: _heightContainer,
                width: size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


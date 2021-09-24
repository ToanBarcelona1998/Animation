import 'dart:math';

import 'package:custom_loading_animation/contains.dart';
import 'package:custom_loading_animation/custom_easy_loading/painter_progress.dart';
import 'package:custom_loading_animation/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum LoadingType { loading, success, error, progress }

_EasyLoadingState? _globalState;

class EasyLoading extends StatefulWidget {
  EasyLoading({this.child, this.duration, Key? key}) : super(key: key);

  final Widget ?child;
  final Duration? duration;

  static _EasyLoadingState? of(BuildContext context) {
    return context.findAncestorRenderObjectOfType();
  }

  static void show({LoadingType? type, String message = ""}) {
    _globalState?._show(type: type, message: message);
  }

  static void dismiss() {
    _globalState?._dismiss();
  }

  static void showLoading({String message = "Loading"}) {
    _globalState?._showLoading(message: message);
  }

  static void updateProgress({double progress = 0.0, String message = "0%"}) {
    _globalState?._updateProgress(progress: progress, text: message);
  }

  static Future<void> showAndAutoDismiss({LoadingType? type, String message = ""}) async {
    await _globalState?._showAndAutoDismiss(type: type, message: message);
  }

  static Future<void> showSuccessAndAutoDismiss({String message = "Success"}) async {
    await _globalState?._showSuccessAutoDismiss(message: message);
  }

  static Future<void> showErrorAndAutoDismiss({String message = "Error"}) async {
    await _globalState?._showErrorAutoDismiss(message: message);
  }

  @override
  _EasyLoadingState createState() => _EasyLoadingState();
}

class _EasyLoadingState extends State<EasyLoading> {
  String _message = "";

  double _opacity = 0.0;
  double _progressValue = 0.0;

  LoadingType? _loadingType;

  bool _isVisible = true;
  bool _isLoading = false;

  @override
  void initState() {
    _globalState = this;
    _loadingType = LoadingType.loading;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  void deactivate() {
    print("chay vao day");
    _isVisible=true;
    _isLoading=false;
    _progressValue=0.0;
    _opacity=0.0;
    _message="";
    _loadingType=LoadingType.loading;
  } //hide loading
  void _dismiss() {
    if (mounted) {
      this._opacity = 0.0;
      if (_isLoading) {
        this._isLoading = false;
      }
      setState(() {});
    }
  }

  //show
  void _show({LoadingType? type, String message = ""}) {
    if (mounted) {
      this._opacity = 1;
      this._isVisible = false;
      this._message = message;
      this._loadingType = type;
      this._isLoading = true;
      setState(() {});
    }
  }

  //show and auto dismiss
  Future<void> _showAndAutoDismiss({LoadingType? type, String message = ""}) async {
    if (mounted) {
      this._show(type: type, message: message);
      Duration duration = Duration(
        milliseconds: max(500 * message.length * 200, 1000),
      );
      if (widget.duration != null) {
        duration = widget.duration!;
      }
      await Future.delayed(duration);
      this._dismiss();
    }
  }

  //update progress
  void _updateProgress({double progress = 0.0, String text = ""}) {
    if (mounted) {
      this._progressValue = progress;
      this._message = text;
    }
    setState(() {});
  }

  //show progress loading
  void _showLoading({String message = "Loading"}) {
    this._show(type: LoadingType.loading, message: message);
  }

  //show success
  Future<void> _showSuccessAutoDismiss({String message = "Success"}) async {
    if (mounted) {
      await this._showAndAutoDismiss(type: LoadingType.success, message: message);
    }
  }

  //show error
  Future<void> _showErrorAutoDismiss({String message = "Error"}) async {
    if (mounted) {
      await this._showAndAutoDismiss(type: LoadingType.error, message: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child!,
          Offstage(
            offstage: _isVisible,
            child: AnimatedOpacity(
              onEnd: () {
                if (_opacity == 0.0 && _isVisible) {
                  _isVisible = false;
                  setState(() {});
                }
              },
              child: _createTypeLoading(),
              duration: Duration(milliseconds: 300),
              opacity: _opacity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTypeLoading() {
    double size = Contains.iconSize;
    switch (_loadingType) {
      case LoadingType.loading:
        Widget _container = Container(
          child: CupertinoTheme(
            data: CupertinoTheme.of(context).copyWith(brightness: Brightness.dark),
            child: CupertinoActivityIndicator(
              radius: Contains.radiusIndicator,
              animating: _isLoading,
            ),
          ),
        );
        return _createWidgetLoading(_container);
      case LoadingType.error:
        return _createWidgetLoading(Icon(
          Icons.close,
          color: AppTheme.colorWhite,
          size: size,
        ));
      case LoadingType.success:
        return _createWidgetLoading(
          Icon(
            Icons.done,
            color: AppTheme.colorWhite,
            size: size,
          ),
        );
      case LoadingType.progress:
        PainterProgress progress = PainterProgress(completePercent:  _progressValue,strokeWidth: 2,completeColor: Colors.red);

        CustomPaint customPaint = CustomPaint(
          painter: progress,
          size: Size(size, size),
        );

        return _createWidgetLoading(customPaint);
      default:
        return Container(
          child: null,
        );
    }
  }

  Widget _createWidgetLoading(Widget child) {
    return Stack(
      children: [
        //isnoring == true các widget con trong nó có thể được bắt sự chạm ngược lại ==false thì không
        IgnorePointer(
          ignoring: true,
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.colorLoading.withOpacity(0.3),
              borderRadius: BorderRadius.circular(Contains.radiusLoading),
            ),
            constraints: BoxConstraints(
              minWidth: Contains.constraintsLoading,
              maxWidth: Contains.constraintsLoading + 50,
              maxHeight: Contains.constraintsLoading,
            ),
            child: Padding(
              padding: EdgeInsets.all(Contains.paddingLoading),
              child: Column(
                children: [
                  child,
                  const SizedBox(height: Contains.paddingApp/2,),
                  Container(
                    child: Text(
                      _message,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppTheme.colorWhite),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

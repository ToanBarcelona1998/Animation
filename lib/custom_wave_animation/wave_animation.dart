import 'package:custom_loading_animation/custom_wave_animation/painter_wave.dart';
import 'package:flutter/material.dart';
class WaveContainer extends StatefulWidget {
  final Duration ?duration;
  final double ?height;
  final double ?width;
  final Color ?waveColor;
  const WaveContainer({
    Key ?key,
    this.duration,
    @required this.height,
    @required this.width,
    this.waveColor,
  }) : super(key: key);
  @override
  _WaveContainerState createState() => _WaveContainerState();
}
class _WaveContainerState extends State<WaveContainer>
    with TickerProviderStateMixin {
  AnimationController ?_animationController;
  Duration ?_duration;
  Color ?_waveColor;
  @override
  void initState() {
    super.initState();
    _duration = widget.duration ?? const Duration(milliseconds: 1000);
    _animationController = AnimationController(vsync: this, duration: _duration);
    _waveColor = widget.waveColor ?? Colors.lightBlueAccent;
    //_animationController?.repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return CustomPaint(
            painter: WavePainter(waveAnimation: _animationController, waveColor: _waveColor),
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    if(_animationController!.isAnimating){
      _animationController?.stop();
    }
    _animationController?.dispose();
    super.dispose();
  }
}
import 'package:custom_loading_animation/custom_circle_progess_bar/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowCircleProgessFile extends StatefulWidget {
  const ShowCircleProgessFile({Key? key}) : super(key: key);

  @override
  _ShowCircleProgessFileState createState() => _ShowCircleProgessFileState();
}

class _ShowCircleProgessFileState extends State<ShowCircleProgessFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ProgressHud.show(ProgressHudType.loading, "Test Hub",);
        },
        child: Icon(Icons.add),
      ),
      body: Container(

      ),
    );
  }
}

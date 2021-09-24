import 'package:custom_loading_animation/dialog.dart';
import 'package:flutter/material.dart';
class CustomDialog extends StatelessWidget with CustomDialogCircle{
  const CustomDialog({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: (){
              showCustomDialog(context,notify: "Làm UI tự custom. Asp.net core 3.0. Các project được dựng sẵn");
            },
            child: Text("Show Custom Dialog"),
          ),
        ),
      ),
    );
  }


}

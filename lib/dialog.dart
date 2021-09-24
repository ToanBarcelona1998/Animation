import 'package:custom_loading_animation/contains.dart';
import 'package:flutter/material.dart';

mixin CustomDialogCircle {
  showCustomDialog(BuildContext context,{String? title, String ?notify}) {
    showDialog(
        context: context,
        builder: (context0) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Contains.radius),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _contentBox(context,title: title,notify: notify),
          );
        });
  }

  Widget _contentBox(BuildContext context, {String? title, String? notify}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: Contains.paddingApp, top: Contains.radius, right: Contains.paddingApp, bottom: Contains.paddingApp),
          margin: EdgeInsets.only(top: Contains.radius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Contains.paddingApp),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title ?? "Thông báo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                notify ?? "Có lỗi xảy ra trong quá trình truy vấn",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22,),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Contains.paddingApp,
          right: Contains.paddingApp,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Contains.radius,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(Contains.radius),
              ),
              child: Image(
                image: AssetImage("assets/images/instagram.png"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

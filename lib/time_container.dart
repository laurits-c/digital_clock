import 'package:flutter/material.dart';

class TimeContainer extends StatelessWidget {
  TimeContainer({this.colors, this.height, this.width, this.time, this.animationValue});
   final Color colors;
   final  double height;
   final  double width;
   final  String time;
   final double animationValue;


  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationY(animationValue),
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: colors,
        ),
        height: height,
        width: width,
        child: Text(time, textAlign: TextAlign.center,),
      ),
    );
  }
}
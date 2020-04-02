// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'time_container.dart';
import 'theme_constants.dart';

/// Digital clock.

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> with TickerProviderStateMixin{
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  int min = DateTime.now().minute;
  double radius =
      double.parse((((DateTime.now().minute) / 5) * 0.1).toStringAsFixed(1));
  Animation rotateMinute;
  Animation rotateHour;
  AnimationController controllerMinute;
  AnimationController controllerHour;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
    controllerMinute = AnimationController(duration: Duration(seconds: 2), vsync: this);
    rotateMinute = Tween<double>(begin: 0.0, end: 2*pi).animate(controllerMinute);
    controllerHour = AnimationController(duration: Duration(seconds: 2), vsync: this);
    rotateHour = Tween<double>(begin: 0.0, end: 2*pi).animate(controllerHour);
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }
void toUpdateAnimation(){
  if (DateFormat('mm').format(_dateTime) == '00') {
    if(controllerHour != null){
      controllerHour.reset();
      controllerHour.forward();
      radius = 0; min = 0;
    }
  }else{
    min += 1;
    if (min % 5 == 0) { radius += 0.1;}
  }
}
  void _updateTime() {
    setState(() {
      toUpdateAnimation();
      if(controllerMinute != null) {
        controllerMinute.reset();
        controllerMinute.forward();
      }
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );


    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? getLightTheme()
        : getDarkTheme();
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final mediaW = MediaQuery.of(context).size.width/ 4;
    final mediaH = MediaQuery.of(context).size.height / 1.5;
    final fontSize = mediaH / 1.5;
    final defaultStyle = TextStyle(
      color: colors[themeElement.text].withAlpha(150),
      fontSize: fontSize,
      fontFamily: 'Tulpen',
      letterSpacing: 2,
    );
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                colors[themeElement.backgroundFrom],
                colors[themeElement.backgroundTo],
              ],
              center: Alignment(0, 0),
              radius: radius,
            )),
        child: AnimatedBuilder(
          animation: controllerMinute,
          builder: (BuildContext context, Widget child){
            return Center(
              child: DefaultTextStyle(
                style: defaultStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TimeContainer(
                      colors:colors[themeElement.cardColor] ,
                      height:mediaH ,
                      width:mediaW ,
                      time:hour ,
                      animationValue: rotateHour.value,
                    ),
                    Container(
                      width: mediaW / 80,
                    ),
                    TimeContainer(
                      colors: colors[themeElement.cardColor],
                      height: mediaH,
                      width: mediaW,
                      time: minute,
                      animationValue: rotateMinute.value,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}

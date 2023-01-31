import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvectech/widgets/text_common_style.dart';

import '../constant/color_constant.dart';

class TextRecordTime extends StatefulWidget{

  TextRecordTime({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<TextRecordTime>{

  late Timer _timer;
  int seconds = 0;
  String _content = '00:00:00';

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    _content = constructTime(seconds);

    return TextCommonStyle(
      content: _content,
      color: ColorConstant.theme,
      size: 14,
    );
  }

  void startTimer() {
    //设置 1 秒回调一次
    const period = Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        seconds++;
      });
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

}

String constructTime(int seconds) {
  int hour = seconds ~/ 3600;
  int minute = seconds % 3600 ~/ 60;
  int second = seconds % 60;
  return '${formatTime(hour)}:${formatTime(minute)}:${formatTime(second)}';
}

String formatTime(int timeNum) {
  return timeNum < 10 ? '0${timeNum.toString()}' : timeNum.toString();
}



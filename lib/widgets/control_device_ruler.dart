import 'dart:ui';

import 'package:flutter/material.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';
typedef VoidCallback = void Function(dynamic value);
double height = 50;
double width = 300;
class ControlDeviceRuler extends StatefulWidget{
  final double position;
  final double maxNum;
  final double minNum;
  final VoidCallback onPressed;
  final bool isZoom;
  ControlDeviceRuler({Key? key, required this.position, required this.maxNum,
    required this.minNum, required this.isZoom, required this.onPressed});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ControlDeviceRuler> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.value = widget.position;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstant.colorTransparent,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

                  GestureDetector(
                    onTap: (){
                      if(_controller.value > widget.minNum){
                        _controller.value = widget.isZoom ? _controller.value - 0.01 : _controller.value - 0.1;
                        if(_controller.value < widget.minNum){
                          _controller.value = widget.minNum;
                        }
                      }
                      widget.onPressed(_controller.value);
                    },
                    child: Image.asset('${Constant.assetsImg}cursorReduce.png', width: 15,),
                  ),

              SizedBox(
                width: 260,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: CustomPaint(
                        painter: DashLinePainter2(max: 1),
                        size: Size(double.maxFinite, height),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: CustomPaint(
                        painter: DashLinePainter(progress: _controller.value/widget.maxNum),
                        size: Size(double.maxFinite, height),
                      ),
                    ),

                    Align(
                      alignment: Alignment(_controller.value/widget.maxNum*2 - (1 + widget.minNum), 0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('${Constant.assetsImg}bg_circle_line.png',
                            width: 30, height: 50,),
                          Text(
                            formatNum(_controller.value*10, 1, widget.isZoom),
                            style: const TextStyle(fontSize: 10, color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.normal),)
                        ],
                      ),
                    ),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbColor: Colors.green,
                        overlayColor: Colors.transparent,
                        inactiveTickMarkColor: Colors.transparent,
                        activeTickMarkColor: Colors.transparent,
                        thumbShape: const RoundSliderThumbShape(//可继承SliderComponentShape自定义形状
                          disabledThumbRadius: 15, //禁用时滑块大小
                          enabledThumbRadius: 0, //滑块大小
                        ),


                      ),
                      child: Slider(
                        value: _controller.value,
                        min: widget.minNum,
                        max: widget.maxNum,
                        divisions: (widget.maxNum*100).toInt(),
                        onChanged: (value) {
                          setState(() {
                            _controller.value = value;
                            widget.onPressed(_controller.value);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

                  GestureDetector(
                    onTap: (){
                      if(_controller.value < widget.maxNum){
                        _controller.value = widget.isZoom ? _controller.value + 0.01 : _controller.value + 0.1;
                        if(_controller.value > widget.maxNum){
                          _controller.value = widget.maxNum;
                        }
                      }
                      widget.onPressed(_controller.value);
                    },
                    child: Image.asset('${Constant.assetsImg}cursorAdd.png', width: 15,),
                  ),
            ],
          );
        },
      ),
    );

  }

  static String formatNum(double num, int fractionDigits, bool isZoom) {
    print('num: $num');
    if(!isZoom){
      return num.round().toString();
    }else if(!num.toString().contains('.')){
      return num.toString();
    } else if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        fractionDigits) {
      //小数点后有几位小数
      return num.toStringAsFixed(fractionDigits)
          .substring(0, num.toString().lastIndexOf(".") + fractionDigits + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + fractionDigits + 1)
          .toString();
    }
  }

}



class DashLinePainter extends CustomPainter {
  final double progress;

  DashLinePainter({required this.progress});

  final Paint _paint = Paint()
    ..color = ColorConstant.theme
    ..strokeWidth = 16.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {

    var path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * progress, size.height / 2);

    Path dashPath = Path();
    double dashWidth = 3.0;
    double dashSpace = 3.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, _paint);
  }

  @override
  bool shouldRepaint(DashLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


class DashLinePainter2 extends CustomPainter {
  final double max;
  DashLinePainter2({Key? key, required this.max});

  final Paint _paint = Paint()
    ..color = ColorConstant.theme
    ..strokeWidth = 16.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * max, size.height / 2);

    Path dashPath = Path();
    double dashWidth = 3.0;
    double dashSpace = 3.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, _paint);
  }

  @override
  bool shouldRepaint(DashLinePainter2 oldDelegate) {
    return false;
  }


}
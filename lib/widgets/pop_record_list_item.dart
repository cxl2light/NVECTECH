import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/text_style_14.dart';

typedef VoidCallback = void Function(dynamic i);

class PopRecordListItem extends StatefulWidget{
  final String buttonText;
  final Color pressedColor;
  final Color defaultColor;
  final Color arrowColor;
  final dynamic index;
  final VoidCallback onPressed;

  const PopRecordListItem(
      {Key? key,
        required this.buttonText,
        required this.pressedColor,
        required this.defaultColor,
        required this.arrowColor,
        required this.index,
        required this.onPressed
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<PopRecordListItem>{
  var _color = ColorConstant.colorTransparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          widget.onPressed(widget.index);
      },
      onTapDown: (TapDownDetails details){
        setState(() {
          _color = widget.pressedColor;
        });
      },
      onTapUp: (TapUpDetails details){
        setState(() {
          _color = widget.defaultColor;
        });
      },
      onTapCancel: ((){
        setState(() {
          _color = widget.defaultColor;
        });
      }),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: _color,
        ),
        child: Column(
          children: [
            Container(
              height: 34,
              alignment: Alignment.center,
              child: TextStyle14(
                content: widget.buttonText,
              ),
            ),


            Container(
              height: 1,
              color: ColorConstant.popLineGray,
            )
          ],
        ),
      ),
    );
  }
}
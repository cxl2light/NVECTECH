import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/text_style.dart';
import 'package:nvectech/widgets/text_style_14.dart';

typedef VoidCallback = void Function();

class SearchResultBtn extends StatefulWidget{
  final String buttonText;
  final Color pressedColor;
  final Color defaultColor;
  final Color arrowColor;
  final VoidCallback onPressed;

   SearchResultBtn(
      {Key? key,
        required this.buttonText,
        required this.pressedColor,
        required this.defaultColor,
        required this.arrowColor,
        required this.onPressed
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<SearchResultBtn>{
  var _color = ColorConstant.theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          widget.onPressed();
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
        color: ColorConstant.colorTransparent,
        child: Align(
          alignment: Alignment.center,
          child: TextStyle14(
            content: widget.buttonText.toUpperCase(),
          ),
        ),
      ),
    );
  }
}
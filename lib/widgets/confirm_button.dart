import 'package:flutter/material.dart';
import 'package:nvectech/widgets/text_style.dart';

typedef VoidCallback = void Function();

class ConfirmButton extends StatefulWidget{
  final String buttonText;
  final Color pressedColor;
  final Color defaultColor;
  final VoidCallback onPressed;

  const ConfirmButton(
      {Key? key,
      required this.buttonText,
      required this.pressedColor,
      required this.defaultColor,
      required this.onPressed
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(defaultColor);
  }

}

class _State extends State<ConfirmButton>{
  var _color;
  _State(Color color){
    _color = color;
  }

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
        alignment: Alignment.center,
        // height: 35.0,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        // child: MyTextStyle(
        //   content: widget.buttonText,
        // ),
      ),
    );
  }
}
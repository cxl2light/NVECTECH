import 'package:flutter/cupertino.dart';

typedef VoidCallback = void Function();

class MyImgButton extends StatefulWidget{
  final String defaultRes;
  final String pressedRes;
  final VoidCallback onPressed;
  final bool isSelected;
  final double width;

  const MyImgButton(
      {Key? key,
        required this.defaultRes,
        required this.pressedRes,
        required this.onPressed,
        required this.isSelected,
        required this.width,
      }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<MyImgButton> {

  @override
  Widget build(BuildContext context) {
    String imgRes = widget.isSelected ? widget.pressedRes: widget.defaultRes;
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      child: Image.asset(
        imgRes,
        width: widget.width,
      ),
    );
  }
}
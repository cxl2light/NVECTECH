import 'package:flutter/cupertino.dart';

typedef VoidCallback = void Function();

class RecordImgButton extends StatefulWidget{
  final String defaultRes;
  final String pressedRes;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool isVideoSelected;
  final double width;

  const RecordImgButton(
      {Key? key,
        required this.defaultRes,
        required this.pressedRes,
        required this.onPressed,
        required this.isSelected,
        required this.isVideoSelected,
        required this.width,
      }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<RecordImgButton> {

  @override
  Widget build(BuildContext context) {
    String imgRes = (widget.isSelected && widget.isVideoSelected) ? widget.pressedRes: widget.defaultRes;
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
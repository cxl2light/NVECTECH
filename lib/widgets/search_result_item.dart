import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/text_common_style.dart';

typedef VoidCallback = void Function();

class SearchResultItem extends StatefulWidget{
  final String buttonText;
  final Color pressedColor;
  final Color defaultColor;
  final VoidCallback onPressed;

  const SearchResultItem(
      {Key? key,
        required this.buttonText,
        required this.pressedColor,
        required this.defaultColor,
        required this.onPressed
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<SearchResultItem>{
  var _color = ColorConstant.colorTransparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
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
      child: SizedBox(
        height: 35,
        child: Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 20.0),
                child: TextCommonStyle(
                  content: widget.buttonText,
                  color: ColorConstant.theme,
                  size: 14.0,
                )
            ),
          ),
        ),
      ),
    );
  }
}
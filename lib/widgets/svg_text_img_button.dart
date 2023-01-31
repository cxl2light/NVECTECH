import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nvectech/constant/color_constant.dart';

typedef VoidCallback = void Function();

class SvgTextImgButton extends StatefulWidget{
  final String defaultRes;
  final String pressedRes;
  final VoidCallback onPressed;
  final bool isSelected;
  final String content;

  const SvgTextImgButton(
      {Key? key,
        required this.defaultRes,
        required this.pressedRes,
        required this.onPressed,
        required this.isSelected,
        required this.content,
      }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<SvgTextImgButton> {

  @override
  Widget build(BuildContext context) {
    String imgRes = widget.isSelected ? widget.pressedRes: widget.defaultRes;
    Color  textColor = widget.isSelected ? ColorConstant.theme : ColorConstant.colorWhite;
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      child: Container(
        width: 50,
        color: ColorConstant.colorTransparent,
        child: Column(
          children: [
            SvgPicture.asset(
              imgRes,
              width: 30,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              widget.content,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10.0, color: textColor, decoration: TextDecoration.none, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
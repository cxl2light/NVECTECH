import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/text_common_style.dart';

typedef VoidCallback = void Function();

class TextImgButton extends StatefulWidget{
  final String defaultRes;
  final String pressedRes;
  final VoidCallback onPressed;
  final bool isSelected;
  final String content;

  const TextImgButton(
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

class _State extends State<TextImgButton> {

  @override
  Widget build(BuildContext context) {
    String imgRes = widget.isSelected ? widget.pressedRes: widget.defaultRes;
    Color  textColor = widget.isSelected ? ColorConstant.themeDark : ColorConstant.theme;
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      child: Container(
        width: 60,
        color: ColorConstant.colorTransparent,
        child: Column(
          children: [
            Image.asset(
              imgRes,
              width: 30,
            ),
            const SizedBox(
              height: 2,
            ),
            TextCommonStyle(content: widget.content, color: textColor, size: 10),
          ],
        ),
      ),
    );
  }
}
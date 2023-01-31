import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/utils/screen_utils.dart';
import 'package:nvectech/widgets/text_common_style.dart';

import '../constant/color_constant.dart';
import '../generated/l10n.dart';

typedef VoidCallback = void Function(dynamic value);
class RulerColorItem extends StatefulWidget{
  final int index;
  final String imgRes;
  final Color textColor;
  final VoidCallback onPressed;
  RulerColorItem({Key? key, required this.index, required this.imgRes, required this.textColor, required this.onPressed(dynamic value)});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<RulerColorItem> {
  var itemBg = ColorConstant.colorTransparent;

  var colorData = [ColorConstant.colorWhite, ColorConstant.colorBlack, ColorConstant.colorRed,
    ColorConstant.colorGreen, ColorConstant.colorGold, ColorConstant.colorViolet];

  var textData = [S.current.colour_atla_white, S.current.colour_atla_black, S.current.colour_atla_red,
    S.current.colour_atla_green, S.current.colour_atla_brownness, S.current.colour_atla_rust];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onPressed(widget.index);
        sendCommand(widget.index);
      },

      child: Container(
        color: itemBg,
        height: 40.0,
        margin: const EdgeInsets.only(top: 15,),
        child: Column(
          children: [

            Align(
              alignment: Alignment.center,
              child: TextCommonStyle(
                content: textData[widget.index],
                color: widget.textColor,
                size: 10,
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 20,
                height: 20,
                margin: const EdgeInsets.only(top: 2.0),
                child: Image.asset(widget.imgRes),
              ),
            ),
          ],
        ),
      ),

    );
  }

  void sendCommand(int index) {
    switch(index){
      case 0:

        break;
      case 1:

        break;
      case 2:

        break;
      case 3:

        break;
      case 4:

        break;
      case 5:

        break;
    }
  }

}
import 'package:flutter/cupertino.dart';
import 'package:nvectech/widgets/text_style_14.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';

typedef VoidCallback = void Function(dynamic index);

class PopItem extends StatefulWidget{
  final String content;
  final VoidCallback onPressed;
  final int index;
  PopItem({Key? key, required this.content, required this.onPressed, required this.index});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<PopItem> {
  var itemBg = ColorConstant.colorTransparent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onPressed(widget.index);
      },

      child: Column(
          children: [
            Container(
              color: ColorConstant.colorTransparent,
              height: 35,
              width: 140,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 10.0),
              child: TextStyle14(
                content: widget.content,
              ),
            ),
          ],
      ),

    );
  }
}
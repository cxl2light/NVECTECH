import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/text_style_14.dart';
import 'package:nvectech/widgets/text_style_16.dart';

import '../constant/constant.dart';

typedef VoidCallback = void Function(dynamic i);

class TabRecord extends StatefulWidget{
  final String buttonText;
  final dynamic index;
  final VoidCallback onPressed;

  const TabRecord(
      {Key? key,
        required this.buttonText,
        required this.index,
        required this.onPressed
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<TabRecord>{


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          widget.onPressed(widget.index);
      },

      child: Container(
        height: 35,
        width: 130,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('${Constant.assetsImg}notificationRecordSelected.png'),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: TextStyle14(
                content: widget.buttonText,
              ),
            ),
            const Spacer(flex: 4,),
          ],
        ),
      ),
    );
  }
}
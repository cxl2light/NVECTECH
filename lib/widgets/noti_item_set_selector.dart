import 'package:flutter/cupertino.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/widgets/text_style_14.dart';

import '../utils/screen_utils.dart';

class NotiItemSetSelector extends StatefulWidget{

  var text;

  NotiItemSetSelector({Key? key, required this.text});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<NotiItemSetSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 140,
        height: 35,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('${Constant.assetsImg}notificationSelected.png'),
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.text.toString().toUpperCase(),
              style: const TextStyle(fontSize: 14.0, color: ColorConstant.theme, decoration: TextDecoration.none, fontWeight: FontWeight.normal),
            ),
          ),
        )
    );
  }
}
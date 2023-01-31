import 'package:flutter/cupertino.dart';

import '../constant/constant.dart';
import '../utils/screen_utils.dart';

class NotiItemSelector extends StatefulWidget{

  var textColor;
  var text;

  NotiItemSelector({Key? key, required this.text, required this.textColor});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<NotiItemSelector> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 245,
      height: 35,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('${Constant.assetsImg}notificationBtnBg.png'),
        ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 10.0),
          child: Text(
            widget.text.toString().toUpperCase(),
            style: TextStyle(fontSize: 14.0, color: widget.textColor, decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontFamily: 'Exo2'),
          ),
        ),
      )
    );
  }
}
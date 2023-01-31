import 'package:flutter/cupertino.dart';

import '../constant/color_constant.dart';

class MyTextStyle extends StatefulWidget{
  final String content;

  MyTextStyle(
      {Key? key,
        required this.content,
      });

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<MyTextStyle>{

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.content,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12.0, color: ColorConstant.theme, decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontFamily: 'Exo2'),
    );
  }
}

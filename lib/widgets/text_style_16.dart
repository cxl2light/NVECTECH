import 'package:flutter/cupertino.dart';

import '../constant/color_constant.dart';

class TextStyle16 extends StatefulWidget{
  final String content;

  TextStyle16(
      {Key? key,
        required this.content,
      });

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<TextStyle16>{

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.content.toUpperCase(),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 16.0, color: ColorConstant.theme, decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontFamily: 'Exo2'),
    );
  }
}

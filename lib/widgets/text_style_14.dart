import 'package:flutter/cupertino.dart';

import '../constant/color_constant.dart';

class TextStyle14 extends StatefulWidget{
  final String content;

  TextStyle14(
      {Key? key,
        required this.content,
      });

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<TextStyle14>{

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.content.toUpperCase(),
      style: const TextStyle(fontSize: 14.0, color: ColorConstant.theme, decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontFamily: 'Exo2'),
    );
  }
}

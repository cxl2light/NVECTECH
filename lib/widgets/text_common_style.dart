import 'package:flutter/cupertino.dart';

import '../constant/color_constant.dart';

class TextCommonStyle extends StatefulWidget{
  final String content;
  final double size;
  final Color color;

  TextCommonStyle(
      {Key? key,
        required this.content,
        required this.color,
        required this.size,
      });

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<TextCommonStyle>{

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.content.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: widget.size, color: widget.color, decoration: TextDecoration.none, fontWeight: FontWeight.normal, fontFamily: 'Exo2'),
    );
  }
}

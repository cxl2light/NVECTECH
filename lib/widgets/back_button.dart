import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constant/constant.dart';

typedef VoidCallback = void Function();

class BackButton extends StatefulWidget{
  final VoidCallback onPressed;

  const BackButton(
      {Key? key,
        required this.onPressed
      }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<BackButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      child: Image.asset(
        '${Constant.assetsImg}back.png',
        height: 20.0,
      ),
    );
  }
}
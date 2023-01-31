import 'package:flutter/cupertino.dart';
import 'package:nvectech/widgets/confirm_button.dart';

import '../constant/constant.dart';

typedef VoidCallback = void Function();

class ImgButton extends StatefulWidget{
  final String defaultRes;
  final String pressedRes;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const ImgButton(
      {Key? key,
        required this.defaultRes,
        required this.pressedRes,
        required this.width,
        required this.height,
        required this.onPressed
  }): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State(defaultRes);
  }

}

class _State extends State<ImgButton> {
  String _default = '${Constant.assetsImg}config.png';

  _State(String defaultRes){
    _default = defaultRes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      onTapDown: (TapDownDetails details){
        setState(() {
          _default = widget.pressedRes;
        });
      },
      onTapUp: (TapUpDetails details){
        setState(() {
          _default = widget.defaultRes;
        });
      },
      onTapCancel: ((){
        setState(() {
          _default = widget.defaultRes;
        });
      }),
      child: Image.asset(
        _default,
        height: widget.height,
      ),
    );
  }
}
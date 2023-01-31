import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';

import '../constant/constant.dart';
import '../widgets/text_common_style.dart';

typedef VoidCallback = void Function(dynamic value);
/// 选择弹框
class PopViewDialog extends StatefulWidget{
  static void showPopWindow(context, title, ok, cancel, onPressed){
    Navigator.push(
      context,
      PopDialogRoute(
        child: PopViewDialog(title: title, ok: ok, cancel: cancel, onPressed: onPressed)
      )
    );
  }

  final String title;
  final String ok;
  final String cancel;
  final VoidCallback onPressed;
  const PopViewDialog({Key? key, required this.title, required this.ok, required this.cancel, required this.onPressed}):super(key:key);

  @override
  State<StatefulWidget> createState() => _SearchPopListView();

}

class PopDialogRoute extends PopupRoute {
  Widget child;

  PopDialogRoute({required this.child});

  @override
  Color? get barrierColor => ColorConstant.colorTransparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'label';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}

class _SearchPopListView extends State<PopViewDialog> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 120,
        width: 220,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('${Constant.assetsImg}dialogYesBg.png'),
          ),
        ),
        child: Column(
          children: [

            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: TextCommonStyle(
                  color: ColorConstant.colorBlack,
                  content: widget.title,
                  size: 16,
                ),
              ),

            ),


            GestureDetector(
              onTap: (){
                widget.onPressed(0);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: ColorConstant.colorTransparent,
                ),
                child: TextCommonStyle(
                  color: ColorConstant.theme,
                  content: widget.ok,
                  size: 16,
                ),
              ),
            ),


            GestureDetector(
              onTap: (){
                widget.onPressed(1);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: ColorConstant.colorTransparent,
                ),
                child: TextCommonStyle(
                  color: ColorConstant.colorBlack,
                  content: widget.cancel,
                  size: 16,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
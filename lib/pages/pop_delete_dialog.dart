import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';

import '../constant/constant.dart';
import '../widgets/text_common_style.dart';

typedef VoidCallback = void Function(dynamic value);
/// 选择弹框
class PopDeleteDialog extends StatefulWidget{
  static void showPopDeleteWindow(context, delete, cancel, onPressed){
    Navigator.push(
      context,
      PopDeleteDialogRoute(
        child: PopDeleteDialog(delete: delete, cancel: cancel, onPressed: onPressed)
      )
    );
  }

  final String delete;
  final String cancel;
  final VoidCallback onPressed;
  const PopDeleteDialog({Key? key, required this.delete, required this.cancel, required this.onPressed}):super(key:key);

  @override
  State<StatefulWidget> createState() => _SearchPopListView();

}

class PopDeleteDialogRoute extends PopupRoute {
  Widget child;

  PopDeleteDialogRoute({required this.child});

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

class _SearchPopListView extends State<PopDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 80,
        width: 220,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('${Constant.assetsImg}dialogDeleteBg.png'),
          ),
        ),
        child: Column(
          children: [

            GestureDetector(
              onTap: (){
                widget.onPressed(0);
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40.0,
                decoration: const BoxDecoration(
                  color: ColorConstant.colorTransparent,
                ),
                child: TextCommonStyle(
                  color: ColorConstant.theme,
                  content: widget.delete,
                  size: 16,
                ),
              ),
            ),


            GestureDetector(
              onTap: (){
                widget.onPressed(1);
                Navigator.pop(context);
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/pop_item.dart';

import '../constant/constant.dart';

typedef VoidCallback = void Function(dynamic index);

class PopList extends StatefulWidget{
  final VoidCallback onPressed;
  final int top;

  const PopList({Key? key, required this.onPressed, required this.top}):super(key:key);

  @override
  State<StatefulWidget> createState() => _State();

}

class PopListRoute extends PopupRoute {
  Widget child;

  PopListRoute({required this.child});

  @override
  Color? get barrierColor => ColorConstant.colorTransparent;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => 'label';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}

class _State extends State<PopList> {
  var itemBg = ColorConstant.colorTransparent;
  final List<String> _listData = SPUtil().get(SPUtil.tempListData);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Spacer(flex: widget.top,),

        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 400),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('${Constant.assetsImg}notificationSelectedList.png'),
              ),
            ),
            child: SizedBox(
              width: 140,
              height: _listData.length*35,
              child: ListView.builder(
                itemCount: _listData.length,
                itemBuilder: (context, i){
                  return PopItem(
                      content: _listData[i],
                      onPressed: (index){
                        setState(() {
                          widget.onPressed(index);
                          Navigator.pop(context);
                        });
                      },
                      index: i);
                },
              ),
            ),
          ),
        ),

        Spacer(flex: 12 - widget.top,),
      ],
    );

  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/widgets/list_view_item.dart';

String flag = '';

/// 菜单列表
class PopListView extends StatefulWidget{
  static void showPopWindow(context, String msg){
    flag = msg;
    Navigator.push(
      context,
      PopRoute(
        child: const PopListView()
      )
    );
  }

  const PopListView({Key? key}):super(key:key);

  @override
  State<StatefulWidget> createState() => _PopListView();

}

class PopRoute extends PopupRoute {
  Widget child;

  PopRoute({required this.child});

  @override
  Color? get barrierColor => ColorConstant.colorGrayTransparent;

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

class _PopListView extends State<PopListView> {
  final _listData = Constant.popIconList;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 280.0,
        child: ListView.builder(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            itemCount: _listData.length,
            itemBuilder: (context, i){
              return ListViewItem(index: i, flag: flag,);
            }
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/utils/screen_utils.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/pop_record_list_item.dart';

typedef VoidCallback = void Function(dynamic index);

class PopRecordList extends StatefulWidget{
  final VoidCallback onPressed;
  final double top;
  final double left;

  const PopRecordList({Key? key, required this.onPressed, required this.top, required this.left,}):super(key:key);

  @override
  State<StatefulWidget> createState() => _State();

}

class PopRecordListRoute extends PopupRoute {
  Widget child;

  PopRecordListRoute({required this.child});

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

class _State extends State<PopRecordList> {
  final List<String> _listData = SPUtil().get(SPUtil.tempListData);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.only(top: widget.top,left: widget.left),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.popFrameBorder),
          color: ColorConstant.popFrameBg,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: _listData.length*35 > 210 ? 210 : _listData.length*35,
            maxWidth: 130,
          ),
            child: ListView.builder(
              itemCount: _listData.length,
              itemBuilder: (context, i){
                return PopRecordListItem(
                  defaultColor: ColorConstant.colorTransparent,
                  pressedColor: ColorConstant.itemBgSelected,
                  buttonText: _listData[i],
                  arrowColor: getArrowColor(i),
                  index: i,
                  onPressed: (index){
                    Navigator.pop(context);
                    widget.onPressed(index);
                  },
                );
              },
            ),
        ),
      ),
    );
  }


}

getArrowColor(int i) {
  if(i == 0) {
    return ColorConstant.theme;
  } else {
    return ColorConstant.colorTransparent;
  }
}
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/widgets/text_style.dart';
import 'package:nvectech/widgets/text_style_14.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../router.dart';
import '../utils/sp_util.dart';

typedef VoidCallback = void Function();
Map<String, dynamic>? map;
class ListViewItem extends StatefulWidget{
  final int index;
  final String flag;
  ListViewItem({Key? key, required this.index, required this.flag});

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<ListViewItem> {
  var itemBg = ColorConstant.colorTransparent;

  final _listData = Constant.popIconList;

  var textData = [S.current.menu_return_to_previous, S.current.menu_connection_guide, S.current.menu_device_management,
    S.current.menu_realtime_vision, S.current.detection_alarm, S.current.menu_about];

  @override
  void initState() {
    map = SPUtil().getJson(SPUtil.deviceInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
        switch(widget.index){
          case 0:
            if(widget.flag.compareTo(Constant.mainFlag) == 0){
              // exit(0);
            } else {
              Navigator.pop(context);
            }
            break;
          case 1:
            MyRouter.pushNoParams(context, MyRouter.help);
            break;
          case 2:
            if(map != null){
              MyRouter.pushNoParams(context, MyRouter.deviceInfo);
            }
            break;
          case 3:
            if(map != null){
              MyRouter.pushNoParams(context, MyRouter.controlDeviceIJK);
            }
            break;
          case 4:
            if(map != null){
              MyRouter.pushNoParams(context, MyRouter.notification);
            }
            break;
          case 5:
            MyRouter.pushNoParams(context, MyRouter.about);
            break;
        }
      },
      onTapDown: (TapDownDetails details){
        setState(() {
          itemBg = ColorConstant.theme;
        });
      },
      onTapUp: (TapUpDetails details){
        setState(() {
          itemBg = ColorConstant.itemBg;
        });
      },
      onTapCancel: ((){
        setState(() {
          itemBg = ColorConstant.itemBg;
        });
      }),

      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(_listData[widget.index]),
          ),
        ),
        height: 35.0,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: TextStyle14(
              content: textData[widget.index],
            ),
          ),
        ),
      ),

    );
  }
}
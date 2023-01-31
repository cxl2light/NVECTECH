import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/widgets/search_result_item.dart';

import '../constant/constant.dart';
import '../utils/sp_util.dart';

typedef VoidCallback = void Function(dynamic value);
/// 菜单列表
class SearchPopListView extends StatefulWidget{
  static void showPopWindow(context, onPressed){
    Navigator.push(
      context,
      SearchPopRoute(
        child: SearchPopListView(onPressed: onPressed,)
      )
    );
  }

  final VoidCallback onPressed;
  const SearchPopListView({Key? key, required this.onPressed}):super(key:key);

  @override
  State<StatefulWidget> createState() => _SearchPopListView();

}

class SearchPopRoute extends PopupRoute {
  Widget child;

  SearchPopRoute({required this.child});

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

class _SearchPopListView extends State<SearchPopListView> {
  List listData = jsonDecode(SPUtil().get(SPUtil.searchResult));
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.only(top: 129, right: 30),
        decoration:  BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('${Constant.assetsImg}selecteDevice${listData.length > 3 ? 3 : listData.length}.png'),
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: listData.length*35 > 105 ? 105 : listData.length*35,
            maxWidth: 144,
          ),
          child: ListView.builder(
              itemCount: listData.length > 3 ? 3 : listData.length,
              itemBuilder: (context, i){
                return SearchResultItem(
                    buttonText: listData[i]['devName'],
                    pressedColor: ColorConstant.colorTransparent,
                    defaultColor: ColorConstant.colorTransparent,
                    onPressed: (){
                      setState(() {
                        widget.onPressed(i);
                      });
                    }
                );
              }
          ),
        ),
      ),
    );
  }
}
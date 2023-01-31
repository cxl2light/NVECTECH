import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/pages/search_pop_list_view.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/back_and_menu.dart';
import 'package:nvectech/widgets/search_result_btn.dart';

import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../main.dart';
import '../widgets/confirm_button.dart';

/// 搜索设备结果
class SearchResult extends StatefulWidget{
  static void showPopWindow(context){
    Navigator.push(
        context,
        PopSearchResult(
            child: const SearchResult()
        )
    );
  }

  const SearchResult({Key? key}):super(key:key);

  @override
  State<StatefulWidget> createState() => _SearchResult();

}

class PopSearchResult extends PopupRoute {
  Widget child;

  PopSearchResult({required this.child});

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

class _SearchResult extends State<SearchResult> {
// [{"softVer":"V3.0.2 Jul 21 2022 14:04:42","hardware":"Cyclops315","devName":"ZS-T400-345"}]
  List listData = jsonDecode(SPUtil().get(SPUtil.searchResult));
  var devName = jsonDecode(SPUtil().get(SPUtil.searchResult))[0]['devName'];

  @override
  void dispose() {
    SPUtil().remove(SPUtil.searchResult);
    SPUtil().remove(SPUtil.deviceInfo);
    fromScanDevice.currentState?.setState(() {
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BackAndMenu(),

        const Spacer(),

        Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 180,
                height: 35,
                margin: const EdgeInsets.only(top: 30.0, ),
                child: ConfirmButton(
                  buttonText: S.of(context).connect_device,
                  defaultColor: ColorConstant.colorTransparent,
                  pressedColor: ColorConstant.colorTransparent,
                  onPressed: (){
                    MyRouter.pushNoParams(context, MyRouter.connectedDevice);
                  },
                ),
              ),
            ),

            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 160,
                height: 35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('${Constant.assetsImg}selectedDevice.png'),
                  ),
                ),
                margin: const EdgeInsets.only(top: 30.0, right: 30.0),
                child: SearchResultBtn(
                  buttonText: devName,
                  defaultColor: ColorConstant.colorTransparent,
                  pressedColor: ColorConstant.colorTransparent,
                  arrowColor: ColorConstant.colorTransparent,
                  onPressed: (){
                    SearchPopListView.showPopWindow(context, (index){
                      setState((){
                        print('showPopWindow index : $index');
                        devName = listData[index]['devName'];
                        SPUtil().setJson(SPUtil.deviceInfo, listData[index]);
                        fromScanDevice.currentState?.setState(() {
                        });
                      });
                    });
                  },
                ),
              ),
            ),
          ],
        ),


      ],
    );
  }
}
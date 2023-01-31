import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/back_and_menu.dart';
import 'package:nvectech/widgets/text_style.dart';

import '../generated/l10n.dart';
import '../widgets/confirm_button.dart';
import '../widgets/img_button.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_style_14.dart';

late FijkPlayer player;
/// 已连接设备
Map<String, dynamic>? map = SPUtil().getJson(SPUtil.deviceInfo);
class ConnectedDevice extends StatefulWidget{
  ConnectedDevice({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<ConnectedDevice> {

  @override
  void initState() {
    print('--------------------------------------------map: ${map.toString()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: Constant.mainBgOpacity,
            image: AssetImage(Constant.backgroundImg),
          )
      ),
      child: Row(
        children: [
          Align(
            child: BackAndMenu(),
          ),

          Expanded(
              child: Column(
                children: [

                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 186,
                      height: 35,
                      margin: const EdgeInsets.only(top: 30.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('${Constant.assetsImg}searchConnectDevice.png'),
                        ),
                      ),
                      child: TextStyle14(
                        content: map!['devName'],
                      ),
                    ),
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ImgButton(
                          defaultRes: '${Constant.assetsImg}android_normal.png',
                          pressedRes: '${Constant.assetsImg}android_normal.png',
                          width: 45,
                          height: 45,
                          onPressed: (){
                            MyRouter.pushNoParams(context, MyRouter.deviceInfo);
                          }),
                      ImgButton(
                          defaultRes: '${Constant.assetsImg}preview.png',
                          pressedRes: '${Constant.assetsImg}preview.png',
                          width: 45,
                          height: 45,
                          onPressed: (){
                            player = FijkPlayer();
                            MyRouter.pushNoParams(context, MyRouter.controlDeviceIJK);
                            Fluttertoast.showToast(
                              msg: S.current.enter_device,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: ColorConstant.itemBg,
                            );
                          }),
                      ImgButton(
                          defaultRes: '${Constant.assetsImg}android_waving.png',
                          pressedRes: '${Constant.assetsImg}android_waving.png',
                          width: 45,
                          height: 45,
                          onPressed: (){
                            MyRouter.pushNoParams(context, MyRouter.notification);
                          }),
                    ],
                  ),

                  const SizedBox(
                    width: 1,
                    height: 10,
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     MyTextStyle(content: S.of(context).device_management),
                  //     MyTextStyle(content: S.of(context).realtime_vision),
                  //     MyTextStyle(content: S.of(context).detection_alarm),
                  //   ],
                  // ),

                  const SizedBox(
                    width: 1,
                    height: 50,
                  ),
                ],
              ),
          ),

          const SizedBox(
            width: 50,
          )

        ],
      ),

    );

  }
}
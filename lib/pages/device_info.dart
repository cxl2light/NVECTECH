import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:nvectech/widgets/text_common_style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/pages/pop_view_dialog.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/widgets/text_style_14.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../utils/sp_util.dart';
import '../widgets/back_and_menu.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_style_16.dart';

Map<String, dynamic>? map = SPUtil().getJson(SPUtil.deviceInfo);
var btnText = S.current.about_version_update_check;
/// 设备信息
class DeviceInfo extends StatefulWidget{
  DeviceInfo({Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<DeviceInfo> {
  bool isAresDevice = false;
  String deviceImage = '${Constant.assetsImg}camera3.png';
  String device = map!['hardware'] ?? '';

  var itemBg = ColorConstant.colorTransparent;
  var textColor = ColorConstant.theme;

  List<String> aresList = ['${Constant.assetsImg}ic_aim_product_01.png', '${Constant.assetsImg}ic_aim_product_02.png',
    '${Constant.assetsImg}ic_aim_product_03.png', '${Constant.assetsImg}ic_aim_product_04.png'];

  List<String> productList = ['${Constant.assetsImg}ProductDescription1.png', '${Constant.assetsImg}ProductDescription2.png',
    '${Constant.assetsImg}ProductDescription3.png', '${Constant.assetsImg}ProductDescription4.png',
    '${Constant.assetsImg}ProductDescription5.png', '${Constant.assetsImg}ProductDescription6.png'];

  @override
  void initState() {
    getVersion(true);
    super.initState();
    if(device.toLowerCase().contains('ares')){
      isAresDevice = true;
      deviceImage = '${Constant.assetsImg}ic_aim_product.png';
    } else {
      isAresDevice = false;
      deviceImage = '${Constant.assetsImg}camera3.png';
    }
  }

  @override
  void dispose() {
    // if (_checkVersionTimer.isActive) {
    //   _checkVersionTimer.cancel();
    // }
    super.dispose();
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

          const Spacer(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              Container(
                width: 400,
                height: 150,
                margin: const EdgeInsets.only(top: 50.0, right: 30.0),
                padding: const EdgeInsets.only(left: 20.0),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('${Constant.assetsImg}deviceManagerBg.png'),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),

                    TextStyle14(content: '${S.of(context).about_product_sn}$device'),
                    const SizedBox(
                      height: 30,
                    ),
                    TextStyle14(content: '${S.of(context).about_current_version}${map!['softVer']}'),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(isAresDevice){
                          MyRouter.push(context, MyRouter.deviceIntroduce, aresList);
                        } else {
                          MyRouter.push(context, MyRouter.deviceIntroduce, productList);
                        }
                      },
                      onTapDown: (TapDownDetails details){
                        setState(() {
                          textColor = ColorConstant.themeDark;
                        });
                      },
                      onTapUp: (TapUpDetails details){
                        setState(() {
                          textColor = ColorConstant.theme;
                        });
                      },
                      onTapCancel: ((){
                        setState(() {
                          textColor = ColorConstant.theme;
                        });
                      }),

                      child: TextCommonStyle(
                        content: S.of(context).about_product_introduction,
                        color: ColorConstant.themeDark,
                        size: 16,
                      ),
                    ),

                    const Spacer(),
                  ],
                ),
              ),


              const SizedBox(
                height: 30,
              ),

              GestureDetector(
                onTap: (){
                  setState(() {
                    getVersion(false);
                  });
                },
                onTapDown: (TapDownDetails details){
                  setState(() {
                    itemBg = ColorConstant.theme;
                  });
                },
                onTapUp: (TapUpDetails details){
                  setState(() {
                    itemBg = ColorConstant.colorTransparent;
                  });
                },
                onTapCancel: ((){
                  setState(() {
                    itemBg = ColorConstant.colorTransparent;
                  });
                }),

                child: Container(
                  width: 300,
                  height: 40,
                  margin: const EdgeInsets.only(right: 30.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('${Constant.assetsImg}checkUpdateBg.png'),
                    ),
                  ),
                  child: TextStyle16(
                    content: btnText,
                  ),
                ),
              )
            ],
          )

        ],
      ),


    );
  }


  void getVersion(bool isFirst) async{
    try {
      String hardware = '[${map!['hardware']}]';
      String softVer = map!['softVer'];
      List<String> softVerList = softVer.split(' ');
      String versionStr = softVerList[0].substring(1,softVerList[0].length);
      int versionCur = int.parse(versionStr.replaceAll('.', ''));

      await Dio().get("https://qinkung1.oss-us-west-1.aliyuncs.com/telescope.ini").then((value){
        String result = value.toString();
        if(result.contains('\r')){
          List<String> list = result.split('\r');
          for(int i = 0; i < list.length; i + 4){
            if(hardware.endsWith(list[i])){
              print('${list[i]}, ${list[i+1].trim()}');
              String vs = list[i+1].replaceAll('version=V', '');
              int version = int.parse(vs.replaceAll('.', ''));
              if(versionCur <= version){
                String url = list[i+2].replaceAll('url=', '');
                if(isFirst){
                  break;
                }
                PopViewDialog.showPopWindow(context, '${S.of(context).new_version_detected}V${vs.trim()}', S.of(context).about_start_update, S.of(context).about_cancel_update,
                        (index){
                      Navigator.pop(context);
                      if(index == 0){
                        // download
                        List<String> nameArr = url.trim().split('/');
                        getApplicationDocumentsDirectory().then((value){
                          Directory documentsDirectory = value;
                          Dio().download(url.trim(), '${documentsDirectory.path}${Platform.pathSeparator}${nameArr[nameArr.length-1]}').then((value) {
                            Response response = value;
                            print("${response.requestOptions.onReceiveProgress}");
                            print('DOWNLOAD SUCCESS ${documentsDirectory.path}${Platform.pathSeparator}${nameArr[nameArr.length-1]}');
                          });
                        });
                      }
                    });
              } else {
                btnText = S.current.new_version_latest;
              }
              break;
            }
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:nvectech/bean/swiper_page_bean.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/widgets/img_button.dart';
import 'package:nvectech/widgets/text_style.dart';
import 'package:nvectech/widgets/text_style_16.dart';

import '../constant/color_constant.dart';
import '../generated/l10n.dart';
import '../widgets/back_button.dart';

/// 搜索帮助详情
class SearchHelpDetail extends StatefulWidget{
  final dynamic mode;
  SearchHelpDetail({Key? key, required this.mode});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<SearchHelpDetail> {

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
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          const Spacer(flex: 2),

          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const Spacer(flex: 2),

                Align(
                  alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Image.asset('${Constant.assetsImg}SearchHelpTitleBg.png'),
                    )
                ),

                const Spacer(),

                Stack(
                  children: [
                    SizedBox(
                      width: 340,
                      child: ImgButton(
                        defaultRes: widget.mode == 1?'${Constant.assetsImg}help_device.png':'${Constant.assetsImg}help_iphone.png',
                        pressedRes: widget.mode == 1?'${Constant.assetsImg}help_device.png':'${Constant.assetsImg}help_iphone.png',
                        width: 340,
                        height: 40,
                        onPressed: (){
                          if(widget.mode == 1){
                            SwiperPageBean bean1 = SwiperPageBean(url: '${Constant.assetsImg}devicehotspot_deviceSetting1.png', title: S.of(context).help_search_device_1);
                            SwiperPageBean bean2 = SwiperPageBean(url: '${Constant.assetsImg}devicehotspot_deviceSetting2.png', title: S.of(context).help_search_device_2);
                            SwiperPageBean bean3 = SwiperPageBean(url: '${Constant.assetsImg}devicehotspot_deviceSetting3.png', title: S.of(context).help_search_device_3);
                            List<SwiperPageBean> imgList = <SwiperPageBean>[bean1, bean2, bean3];

                            MyRouter.push(context, MyRouter.helpSearchDeviceSetting, imgList);

                          } else if(widget.mode == 2){

                            SwiperPageBean bean1 = SwiperPageBean(url: '${Constant.assetsImg}iphoneHotspot_iphoneSettings1.png', title: S.of(context).help_search_mobile_1);
                            SwiperPageBean bean2 = SwiperPageBean(url: '${Constant.assetsImg}iphoneHotspot_iphoneSettings2.png', title: S.of(context).help_search_mobile_2);
                            SwiperPageBean bean3 = SwiperPageBean(url: '${Constant.assetsImg}iphoneHotspot_iphoneSettings3.png', title: S.of(context).help_search_mobile_3);
                            List<SwiperPageBean> imgList = <SwiperPageBean>[bean1, bean2, bean3];

                            MyRouter.push(context, MyRouter.helpSearchPhoneSetting, imgList);
                          } else if(widget.mode == 3){

                            SwiperPageBean bean1 = SwiperPageBean(url: '${Constant.assetsImg}wifi_iphoneSettins1.png', title: S.of(context).help_search_wifi_1);
                            SwiperPageBean bean2 = SwiperPageBean(url: '${Constant.assetsImg}wifi_iphoneSettins2.png', title: S.of(context).help_search_wifi_2);
                            SwiperPageBean bean3 = SwiperPageBean(url: '${Constant.assetsImg}wifi_iphoneSettins3.png', title: S.of(context).help_search_wifi_3);
                            List<SwiperPageBean> imgList = <SwiperPageBean>[bean1, bean2, bean3];

                            MyRouter.push(context, MyRouter.helpSearchPhoneSetting, imgList);
                          }
                        },
                      ),
                    ),

                    IgnorePointer(
                      child: Container(
                        width: 340,
                        height: 40,
                        alignment: Alignment.center,
                        child: TextStyle16(
                          content:'1    ${ widget.mode == 1?S.of(context).help_device_setting:S.of(context).help_phone_setting}',
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Stack(
                  children: [
                    SizedBox(
                      width: 340,
                      child: ImgButton(
                        defaultRes: widget.mode == 1?'${Constant.assetsImg}help_iphone.png':'${Constant.assetsImg}help_device.png',
                        pressedRes: widget.mode == 1?'${Constant.assetsImg}help_iphone.png':'${Constant.assetsImg}help_device.png',
                        width: 340,
                        height: 40,
                        onPressed: (){
                          if(widget.mode == 1){

                            SwiperPageBean bean1 = SwiperPageBean(url: '${Constant.assetsImg}devicehotspot_iphoneSetting1.png', title: S.of(context).help_search_device_4);
                            SwiperPageBean bean2 = SwiperPageBean(url: '${Constant.assetsImg}devicehotspot_iphoneSetting2.png', title: S.of(context).help_search_device_5);
                            SwiperPageBean bean3 = SwiperPageBean(url: '${Constant.assetsImg}devicehotspot_iphoneSetting3.png', title: S.of(context).help_search_device_6);
                            List<SwiperPageBean> imgList = <SwiperPageBean>[bean1, bean2, bean3];

                            MyRouter.push(context, MyRouter.helpSearchPhoneSetting, imgList);
                          } else if(widget.mode == 2){
                            SwiperPageBean bean1 = SwiperPageBean(url: '${Constant.assetsImg}iphoneHotspot_deviceSettings1.png', title: S.of(context).help_search_mobile_4);
                            SwiperPageBean bean2 = SwiperPageBean(url: '${Constant.assetsImg}iphoneHotspot_deviceSettings2.png', title: S.of(context).help_search_mobile_5);
                            SwiperPageBean bean3 = SwiperPageBean(url: '${Constant.assetsImg}iphoneHotspot_deviceSettings3.png', title: S.of(context).help_search_mobile_6);
                            List<SwiperPageBean> imgList = <SwiperPageBean>[bean1, bean2, bean3];

                            MyRouter.push(context, MyRouter.helpSearchDeviceSetting, imgList);
                          } else if(widget.mode == 3){
                            SwiperPageBean bean1 = SwiperPageBean(url: '${Constant.assetsImg}wifi_deviceSettins1.png', title: S.of(context).help_search_wifi_4);
                            SwiperPageBean bean2 = SwiperPageBean(url: '${Constant.assetsImg}wifi_deviceSettins2.png', title: S.of(context).help_search_wifi_5);
                            SwiperPageBean bean3 = SwiperPageBean(url: '${Constant.assetsImg}wifi_deviceSettins3.png', title: S.of(context).help_search_wifi_6);
                            List<SwiperPageBean> imgList = <SwiperPageBean>[bean1, bean2, bean3];

                            MyRouter.push(context, MyRouter.helpSearchDeviceSetting, imgList);
                          }
                        },
                      ),
                    ),

                    IgnorePointer(
                      child: Container(
                        width: 340,
                        height: 40,
                        alignment: Alignment.center,
                        child: TextStyle16(
                          content:'2    ${ widget.mode == 1?S.of(context).help_phone_setting:S.of(context).help_device_setting}',
                        ),
                      ),
                    ),

                  ],
                ),

                const Spacer(),

                Stack(
                  children: [
                    SizedBox(
                      width: 340,
                      child: ImgButton(
                        defaultRes: '${Constant.assetsImg}help_search.png',
                        pressedRes: '${Constant.assetsImg}help_search.png',
                        width: 340,
                        height: 40,
                        onPressed: (){
                          MyRouter.pushNoParams(context, MyRouter.homePage);
                        },
                      ),
                    ),

                    IgnorePointer(
                      child: Container(
                        width: 340,
                        height: 40,
                        alignment: Alignment.center,
                        child: TextStyle16(
                          content:'3    ${S.of(context).help_search_device}',
                        ),
                      ),
                    ),

                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:nvectech/bean/swiper_page_bean.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/widgets/confirm_button.dart';
import 'package:nvectech/widgets/text_style.dart';

import '../constant/color_constant.dart';
import '../generated/l10n.dart';
import '../widgets/back_button.dart';

/// 搜索帮助
class SearchHelp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _SearchHelp();
  }

}

class _SearchHelp extends State<SearchHelp> {

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
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 20.0, top: 20),
              child: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ),


          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [

                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 80,
                          child: Image.asset('${Constant.assetsImg}byDeviceV2.png'),
                        ),
                      ),

                      const SizedBox(
                        width: 1,
                        height: 20,
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 80,
                          child: Image.asset('${Constant.assetsImg}byIphoneV2.png'),
                        ),
                      ),

                      const SizedBox(
                        width: 1,
                        height: 20,
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 80,
                          child: Image.asset('${Constant.assetsImg}byWifiV2.png'),
                        ),
                      ),

                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 353,
                      child: Column(
                        children: [

                          const SizedBox(
                            width: 1,
                            height: 20,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(right: 20),
                              child: ConfirmButton(
                                buttonText: S.of(context).base_enter,
                                defaultColor: ColorConstant.colorTransparent,
                                pressedColor: ColorConstant.colorTransparent,
                                onPressed: (){
                                  MyRouter.push(context, MyRouter.helpDetail, 1);
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                            height: 60,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(right: 20),
                              child: ConfirmButton(
                                buttonText: S.of(context).base_enter,
                                defaultColor: ColorConstant.colorTransparent,
                                pressedColor: ColorConstant.colorTransparent,
                                onPressed: (){
                                  MyRouter.push(context, MyRouter.helpDetail, 2);
                                },
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 1,
                            height: 60,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 100,
                              height: 40,
                              margin: const EdgeInsets.only(right: 20),
                              child: ConfirmButton(
                                buttonText: S.of(context).base_enter,
                                defaultColor: ColorConstant.colorTransparent,
                                pressedColor: ColorConstant.colorTransparent,
                                onPressed: (){
                                  MyRouter.push(context, MyRouter.helpDetail, 3);
                                },
                              ),
                            ),
                          ),

                        ],
                      ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/text_common_style.dart';

import '../generated/l10n.dart';
import '../widgets/back_and_menu.dart';
import '../widgets/text_style_16.dart';

/// 关于设备
class About extends StatefulWidget{
  About({Key? key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<About> {

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

          Container(
            width: 400,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('${Constant.assetsImg}aboutBg.png'),
              ),
            ),

            child: Column(
              children: [

                const Spacer(),

                Align(
                  alignment: Alignment.center,
                  child: TextStyle16(content: '${S.of(context).app_name}  V${SPUtil().get(SPUtil.version)}'),
                ),

                Align(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15),
                    child: TextStyle16(content: S.of(context).app_about),
                  ),
                ),

                Align(
                  child: GestureDetector(
                    onTap: (){
                      MyRouter.push(context, Constant.url, S.of(context).laws_title);
                    },

                    child: TextCommonStyle(
                      content: S.of(context).laws_title,
                      color: ColorConstant.themeDark,
                      size: 18,
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),

          const Spacer(flex: 2,),
        ],
      ),

    );

  }
}
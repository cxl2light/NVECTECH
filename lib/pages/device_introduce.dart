import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/utils/screen_utils.dart';

import '../widgets/back_and_menu.dart';

/// 设备信息介绍
class DeviceIntroduce extends StatefulWidget{
  final List<String> imgList;
  DeviceIntroduce({Key? key, required this.imgList}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<DeviceIntroduce> {

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
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(widget.imgList[index], height: ScreenUtils.screenH(context)*3/4);
              },
              itemCount: widget.imgList.length,
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: ColorConstant.theme,
                  activeColor: ColorConstant.themeDark,
                  size: 8.0,
                  activeSize: 8.0,
                  space: 4.0
                )
              ),
            ),
          ),

          const SizedBox(
            width: 20,
          )
        ],
      ),
    );

  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/widgets/text_style.dart';

import '../bean/swiper_page_bean.dart';
import '../widgets/back_button.dart';
import '../widgets/text_style_16.dart';

/// 搜索设备设置
class SearchHelpDeviceSetting extends StatefulWidget{
  final List<SwiperPageBean> imgList;
  SearchHelpDeviceSetting({Key? key, required this.imgList}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<SearchHelpDeviceSetting> {

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
              margin: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: BackButton(
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ),

          Expanded(
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(widget.imgList[index].url, width: 350,),
                    ),

                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextStyle16(content: widget.imgList[index].title),
                    ),

                    const SizedBox(
                      width: 20,
                    ),
                  ],
                );
              },
              itemCount: widget.imgList.length,
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: ColorConstant.theme,
                  activeColor: ColorConstant.themeDark,
                  size: 6.0,
                  activeSize: 6.0,
                  space: 4.0
                )
              ),
            ),
          ),

        ],
      ),
    );

  }
}
import 'package:flutter/cupertino.dart';
import 'package:nvectech/widgets/back_button.dart';

import '../constant/constant.dart';
import '../pages/pop_list_view.dart';
import 'img_button.dart';

class BackAndMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, left: 30.0),
            child: BackButton(
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ),
        const Spacer(),
        Align(
          child: Container(
            margin: const EdgeInsets.only(bottom: 30.0, left: 30.0),
            child: ImgButton(
              defaultRes: '${Constant.assetsImg}config.png',
              pressedRes: '${Constant.assetsImg}config.png',
              width: 20.0,
              height: 20.0,
              onPressed: (){
                PopListView.showPopWindow(context, '');
              },
            ),
          ),
        ),
      ],
    );
  }

}
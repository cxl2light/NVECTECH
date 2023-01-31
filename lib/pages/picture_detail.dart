
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nvectech/pages/pop_delete_dialog.dart';
import 'package:nvectech/widgets/text_style_14.dart';

import '../constant/constant.dart';
import '../generated/l10n.dart';
import '../utils/screen_utils.dart';
import '../widgets/text_style_16.dart';

class PictureDetail extends StatefulWidget{
  final String url;
  const PictureDetail({Key? key, required this.url}):super(key: key);

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<PictureDetail> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: ScreenUtils.screenH(context)*5/4,
            height: ScreenUtils.screenH(context),
            child: Image.asset(widget.url),
          ),
        ),


        GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            height: 60,
            width: 100,
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(right: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('${Constant.assetsImg}ijkImgBtnBg.png'),
              ),
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextStyle14(
                content: S.of(context).back,
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: (){
              // TODO SHARE

            },
            child: Container(
              height: 60,
              width: 100,
              margin: const EdgeInsets.only(top: 20),
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('${Constant.assetsImg}ijkImgBtnBg2.png'),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextStyle14(
                  content: S.of(context).operate_share,
                ),
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: (){
              PopDeleteDialog.showPopDeleteWindow(context, S.of(context).delete, S.of(context).cancel, (index){
                if(index == 0){
                  deleteFile(widget.url);
                  Navigator.pop(context);
                }
              });
            },
            child: Container(
              height: 60,
              width: 100,
              margin: const EdgeInsets.only(top: 100),
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('${Constant.assetsImg}ijkImgBtnBg2.png'),
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextStyle14(
                  content: S.of(context).operate_delete,
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

Future<void> deleteFile(String path) async {
  try {
    var file = File(path);
    if (await file.exists()) {
      await file.delete();
      print("delete ok!");
    }

  } catch (e) {
    print(e.toString());
  }
}
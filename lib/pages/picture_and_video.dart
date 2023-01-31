import 'dart:io';

import 'package:ffmpeg_kit_flutter_https/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_https/ffmpeg_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/widgets/text_style_14.dart';
import 'package:nvectech/widgets/text_style_16.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nvectech/generated/l10n.dart';
import 'package:nvectech/pages/control_device_ijk.dart';

import '../constant/color_constant.dart';
import '../constant/constant.dart';
import '../widgets/back_button.dart';

bool showPicture = true;
/// 图片和视频
class PictureAndVideo extends StatefulWidget{
  const PictureAndVideo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();

}

class _State extends State<PictureAndVideo> {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

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


          Visibility(
            visible: showPicture,
              child: Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: imageList.length,
                    itemBuilder: (context, index){
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            MyRouter.push(context, MyRouter.pictureDetail, imageList[index]);
                          });
                        },
                        child: Image.asset(imageList[index]),
                      );
                    }),
              ),
          ),

          Visibility(
            visible: !showPicture,
            child: Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: videoList.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          print('onPress:$index');
                        });
                      },
                      child: FutureBuilder(
                        future: getFirstFrame(index),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            return Image.asset(snapshot.data as String);
                          }
                          return const Text('Error');
                        },
                      ),
                    );
                  }),
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [

                Expanded(child: GestureDetector(
                  onTap: (){
                    setState(() {
                      showPicture = true;
                    });
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.only(right: 30),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('${Constant.assetsImg}fileImageBtnBg.png'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        S.of(context).str_picture,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: showPicture ? ColorConstant.themeDark : ColorConstant.theme,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                )),


                const SizedBox(
                  width: 20,
                  height: 1,
                ),

                Expanded(child: GestureDetector(
                  onTap: (){
                    setState(() {
                      showPicture = false;
                    });
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 30),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('${Constant.assetsImg}fileVideoBtnBg.png'),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.of(context).str_video,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: showPicture ? ColorConstant.theme : ColorConstant.themeDark,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

  Future<String> getFirstFrame(int index) async{

    print('********************************v************************************');
    print(videoList[index]);
    print('********************************v************************************');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String imagePath = '${documentsDirectory.path}${Platform.pathSeparator}videoImage/$index.img';
    await FFmpegKit.execute(' -i ${videoList[index]} -ss 1 -f image2 $imagePath');
    print('**********************************************************************');
    print(imagePath);
    print('**********************************************************************');
    return imagePath;
  }
}
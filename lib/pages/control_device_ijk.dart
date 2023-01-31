import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:ffmpeg_kit_flutter_https/ffmpeg_kit.dart';



import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/generated/l10n.dart';
import 'package:nvectech/native_add.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/utils/screen_utils.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/control_device_ruler.dart';

import 'package:nvectech/widgets/record_img_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/img_button.dart';
import '../widgets/ruler_color_item.dart';
import '../widgets/svg_img_button.dart';
import '../widgets/text_img_button.dart';
import '../widgets/text_record_time.dart';
import 'connected_device.dart';

double zoomPosition = 0.1;
double zoomMax = 0.6;
double zoomMin = 0.1;
double sharpnessPosition = 0.5;
double sharpnessMax = 1;
double sharpnessMin = 0;
double contrastPosition = 0.5;
double contrastMax = 1;
double contrastMin = 0.1;
double brightnessPosition = 0.5;
double brightnessMax = 1;
double brightnessMin = 0.1;
double filteringPosition = 0.5;
double filteringMax = 1;
double filteringMin = 0;
double reticlePosition = 0;
double reticleMax = 0.7;
double reticleMin = 0;

bool isRangingSelected = false;
bool isZoomSelected = false;
bool isImgSettingSelected = false;
bool isSystemSettingSelected = false;

bool isSharpnessSelected = false;
bool isContrastSelected = false;
bool isBrightnessSelected = false;
bool isFilteringSelected = false;

bool isRulerSelected = false;
bool isPlaySelected = false;
bool isFolderSelected = false;

bool isPictureSelected = true;
bool isVideoSelected = false;

bool isReticleSelected = false;
bool isPipSelected = false;
bool isTrackingSelected = false;

int indexVale = 0;

bool isGetDeviceConfigStarted = false;
late Timer ijkTimer;
int count = 0;

String ip = SPUtil().getJson(SPUtil.deviceInfo)!['ip'];
// String ip = '192.168.1.73';

Pointer<Int8> nativeValue = ip.toNativeUtf8().cast<Int8>();
int channelNo = initDevice(nativeValue);

late String imagePath;
late String path;
late List<String> imageList = [];
late List<String> videoList = [];
String IMAGE = 'image';
String VIDEO = 'video';

GlobalKey fromRecordTime = GlobalKey();
GlobalKey fromToast = GlobalKey();

void startGetJsonDeviceConfig(){
  initGetDeviceConfig(channelNo);

  ijkTimer = Timer.periodic (const Duration(milliseconds: 6000), (timer) {
  print('count : $count');
    try{
      if(count%2 == 0){
        Pointer<Int8> result = getJsonDev();
        if(result.toString().endsWith('address=0x0') || result.value == 0){
          print('result is empty');
        } else {
          Map<String, dynamic> jsonDevice = jsonDecode(result.cast<Utf8>().toDartString());
          indexVale = jsonDevice['palette'];
          zoomPosition = (jsonDevice['zoom'])/100.0;
          sharpnessPosition = (jsonDevice['sharpness'])/10.0;
          contrastPosition = (jsonDevice['contrast'])/10.0;
          brightnessPosition = (jsonDevice['brightness'])/10.0;
          filteringPosition = (jsonDevice['noiseReduction'])/10.0;
          reticlePosition = (jsonDevice['reticle'])/10.0;
          isPipSelected = (jsonDevice['pipEnable'])==1 ? true : false;
          isRangingSelected = (jsonDevice['distanceEn'])==1 ? true : false;
          isTrackingSelected = (jsonDevice['trackEn'])==1 ? true : false;
        }
        initGetAnalyseresult(channelNo);
      } else {
        Pointer<Int8> analyseResult = getJsonAnalyseResult();
        if(analyseResult.toString().endsWith('address=0x0') || analyseResult.value == 0){
          print('analyseResult is empty');
        } else {
          Map<String, dynamic> jsonAnalyse = jsonDecode(analyseResult.cast<Utf8>().toDartString());
          print('analyseResult : ${jsonAnalyse.toString()}');

        }
        initGetDeviceConfig(channelNo);
      }

      count ++;


    } catch(error){
      print('Error: $error');
    }

  });

}

///将回调拿到的Uint8List格式的图片转换为File格式
saveImage(Uint8List imageByte) async {
  //获取目录
  await createDir(IMAGE);
  //生成file文件格式
  var file =
  await File('$path/image_${DateTime.now().millisecondsSinceEpoch}.jpg')
      .create();

  //转成file文件
  file.writeAsBytesSync(imageByte);
  imagePath = file.path;
  print("imagePath: $imagePath");
  dirList(IMAGE);
}

saveVideo() async {
  //获取目录
  await createDir(VIDEO);
  if(isPlaySelected){
    // FFmpegKit.execute("-i rtsp://$ip:554/mainstream –vcodec copy $path/video_${DateTime.now().millisecondsSinceEpoch}.mp4");
    FFmpegKit.execute(' -i rtsp://$ip:554/mainstream -acodec copy -vcodec copy $path/video_${DateTime.now().millisecondsSinceEpoch}.mp4');
  } else {
    FFmpegKit.cancel();
  }

  dirList(VIDEO);
}

/// 创建文件目录
createDir(String fileName) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  path = '${documentsDirectory.path}${Platform.pathSeparator}$fileName';
  var dir = Directory(path);
  var exist = dir.existsSync();
  if (exist) {
    print('当前文件夹已经存在');
  } else {
    var result = await dir.create();
    print('$result');
  }
}

/// 遍历目录下的文件
dirList(String fileName) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = '${documentsDirectory.path}${Platform.pathSeparator}$fileName';

  Stream<FileSystemEntity> fileList = Directory(path).list();
  if(fileName.compareTo(IMAGE) == 0){
    imageList.clear();
  } else {
    videoList.clear();
  }

  await for(FileSystemEntity fileSystemEntity in fileList){
    if(fileName.compareTo(IMAGE) == 0){
      imageList.add(fileSystemEntity.path);
    } else {
      videoList.add(fileSystemEntity.path);
    }

  }
}




/// 动态申请权限，ios 要在info.plist 上面添加
/// 动态申请权限，需要区分android和ios，很多时候它两配置权限时各自的名称不同
/// 此处以保存图片需要的配置为例
Future<bool> requestPermission(BuildContext context) async {
  late PermissionStatus status;
  // 1、读取系统权限的弹框
  if (Platform.isIOS) {
    status = await Permission.photosAddOnly.request();
  } else {
    status = await Permission.storage.request();
  }
  // 2、假如你点not allow后，下次点击不会在出现系统权限的弹框（系统权限的弹框只会出现一次），
  // 这时候需要你自己写一个弹框，然后去打开app权限的页面
  if (status != PermissionStatus.granted) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('You need to grant album permissions'),
            content: const Text(
                'Please go to your mobile phone to set the permission to open the corresponding album'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('cancle'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text('confirm'),
                onPressed: () {
                  Navigator.pop(context);
                  // 打开手机上该app权限的页面
                  openAppSettings();
                },
              ),
            ],
          );
        });
  } else {
    return true;
  }
  return false;
}

// 保存图片的权限校验
checkPermission(Future<dynamic> fun, BuildContext context) async {
  bool mark = await requestPermission(context);
  mark ? fun : null;
}

// 保存APP里的图片
saveAssetsImg() async {
  player.takeSnapShot().then((value) async{
    saveImage(value);
    Fluttertoast.showToast(
      msg: S.current.tip_save_success,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: ColorConstant.itemBg,
    );
  });
}



/// 实时视频控制
class ControlDeviceIJK extends StatefulWidget{
  ControlDeviceIJK({Key? key}):super(key: key);

  @override
  State<StatefulWidget> createState() => _State();

}


class _State extends State<ControlDeviceIJK> {
  var textDefault = ColorConstant.theme;
  var textSelected = ColorConstant.themeDark;

  @override
  void initState() {
    super.initState();
    if(!isGetDeviceConfigStarted){
      startGetJsonDeviceConfig();
    }

    String FIJK_STATE = 'FijkState.completed,FijkState.error';
    String url = 'rtsp://$ip:554/mainstream';
    // String url = '/var/mobile/Containers/Data/Application/49368D49-D9FC-4E88-9CED-C0F2144289DA/Documents/video/video_1664349564948.mp4';
    player.setDataSource(url, autoPlay: true);
    player.addListener(() {
      print('LISTENER: ${FIJK_STATE.contains(player.state.toString())}');
      if(FIJK_STATE.contains(player.state.toString())){
        player.reset().then((value){
          print('Listener: Player Reset');
          player.setDataSource(url, autoPlay: true);
        });

      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(ijkTimer.isActive){
      ijkTimer.cancel();
    }
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Row(
          children: [

            Positioned.fill(  //使用绝对定位可全局渐变（可不用）
              child: Container(
                width: ScreenUtils.screenW(context)/4,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(      //渐变位置
                        begin: Alignment.centerLeft, //左
                        end: Alignment.centerRight, //右
                        stops: [0.0, 1.0],         //[渐变起始点, 渐变结束点]
                        //渐变颜色[始点颜色, 结束颜色]
                        colors: [ColorConstant.rtspBg, ColorConstant.rtspBg2]
                    )
                ),
              ),
            ),

            const Spacer(),

            Positioned.fill(  //使用绝对定位可全局渐变（可不用）
              child: Container(
                width: ScreenUtils.screenW(context)/4,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(      //渐变位置
                        begin: Alignment.centerLeft, //左
                        end: Alignment.centerRight, //右
                        stops: [0.0, 1.0],         //[渐变起始点, 渐变结束点]
                        //渐变颜色[始点颜色, 结束颜色]
                        colors: [ColorConstant.rtspBg2, ColorConstant.rtspBg]
                    )
                ),
              ),
            ),



          ],
        ),

        Row(
          children: [

            /// 左边菜单
            SizedBox(
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Image.asset('${Constant.assetsImg}ijkImgBtnBg.png', height: 60,fit: BoxFit.fill,),

                      Container(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TextImgButton(
                          defaultRes: '${Constant.assetsImg}distance_measurement2.png',
                          pressedRes: '${Constant.assetsImg}distance_measurement_highlighted2.png',
                          content: S.of(context).control_left_ranging,
                          isSelected: isRangingSelected,
                          onPressed: (){
                            setState(() {
                              isRangingSelected = isRangingSelected ? false : true;
                              setDistanceEnable(channelNo, isRangingSelected ? 1 : 0);
                            });

                          },
                        ),
                      ),

                    ],
                  ),


                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Image.asset('${Constant.assetsImg}ijkImgBtnBg.png', height: 60,fit: BoxFit.fill,),

                      Container(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: TextImgButton(
                          defaultRes: '${Constant.assetsImg}zoom.png',
                          pressedRes: '${Constant.assetsImg}zoom_h.png',
                          content: S.of(context).control_left_zoom,
                          isSelected: isZoomSelected,
                          onPressed: (){
                            setState(() {
                              isZoomSelected = isZoomSelected ? false : true;
                              isRulerSelected = false;
                              isImgSettingSelected = false;
                              isSystemSettingSelected = false;
                            });

                          },
                        ),
                      ),

                    ],
                  ),

                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Image.asset('${Constant.assetsImg}ijkImgBtnBg.png', height: 60,fit: BoxFit.fill,),

                      Container(
                        padding: const EdgeInsets.only(right: 5.0),
                        child:TextImgButton(
                          defaultRes: '${Constant.assetsImg}image.png',
                          pressedRes: '${Constant.assetsImg}image_highlighted.png',
                          content: S.of(context).control_left_image_setting,
                          isSelected: isImgSettingSelected,
                          onPressed: (){
                            setState(() {
                              isImgSettingSelected = isImgSettingSelected ? false : true;
                              isRulerSelected = false;
                              isZoomSelected = false;
                              isSystemSettingSelected = false;
                            });

                          },
                        ),
                      ),

                    ],
                  ),

                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Image.asset('${Constant.assetsImg}ijkImgBtnBg.png', height: 60,fit: BoxFit.fill,),

                      Container(
                        padding: const EdgeInsets.only(right: 5.0),
                        child:TextImgButton(
                          defaultRes: '${Constant.assetsImg}sysconfig.png',
                          pressedRes: '${Constant.assetsImg}sysconfig_highlighted.png',
                          content: S.of(context).control_left_system_setting,
                          isSelected: isSystemSettingSelected,
                          onPressed: (){
                            setState(() {
                              isSystemSettingSelected = isSystemSettingSelected ? false : true;
                              isRulerSelected = false;
                              isZoomSelected = false;
                              isImgSettingSelected = false;
                            });

                          },
                        ),
                      ),

                    ],
                  ),

                ],
              ),
            ),

            const Spacer(),

            /// 视频区
            SizedBox(
              width: ScreenUtils.screenH(context)*5/4,
              height: ScreenUtils.screenH(context),
              child: Stack(
                children: [
                  Container(
                    // width: ScreenUtils.screenH(context)*5/4,
                    // height: ScreenUtils.screenH(context),
                    color: ColorConstant.colorBlack,
                    child: Scaffold(
                      body: FijkView(
                        width: ScreenUtils.screenH(context)*5/4,
                        height: ScreenUtils.screenH(context),
                        player: player,
                        color: ColorConstant.colorBlack,
                        onDispose: (value){
                          print('data: ${value.toString()}');
                        },
                      ),
                    ),
                  ),

                  Container(
                    width: ScreenUtils.screenH(context)*5/4,
                    height: ScreenUtils.screenH(context),
                    color: ColorConstant.colorTransparent,
                  ),

                  /// 图像设置
                  Visibility(
                    visible: isImgSettingSelected,
                    child: Container(
                      width: 80,
                      color: ColorConstant.itemBg,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}Sharpness.png',
                            pressedRes: '${Constant.assetsImg}Sharpness_highlighted.png',
                            content: S.of(context).str_sharpness,
                            isSelected: isSharpnessSelected,
                            onPressed: (){
                              setState(() {
                                isSharpnessSelected = isSharpnessSelected ? false : true;
                                isContrastSelected = false;
                                isBrightnessSelected = false;
                                isFilteringSelected = false;
                              });

                            },
                          ),
                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}Contrast.png',
                            pressedRes: '${Constant.assetsImg}Contrast_highlighted.png',
                            content: S.of(context).str_contrast,
                            isSelected: isContrastSelected,
                            onPressed: (){
                              setState(() {
                                isContrastSelected = isContrastSelected ? false : true;
                                isSharpnessSelected = false;
                                isBrightnessSelected = false;
                                isFilteringSelected = false;
                              });

                            },
                          ),
                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}brightness.png',
                            pressedRes: '${Constant.assetsImg}brightness_h.png',
                            content: S.of(context).str_brightness,
                            isSelected: isBrightnessSelected,
                            onPressed: (){
                              setState(() {
                                isBrightnessSelected = isBrightnessSelected ? false : true;
                                isContrastSelected = false;
                                isSharpnessSelected = false;
                                isFilteringSelected = false;
                              });

                            },
                          ),
                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}NoiseReduction.png',
                            pressedRes: '${Constant.assetsImg}NoiseReduction_h.png',
                            content: S.of(context).str_filtering,
                            isSelected: isFilteringSelected,
                            onPressed: (){
                              setState(() {
                                isFilteringSelected = isFilteringSelected ? false : true;
                                isContrastSelected = false;
                                isSharpnessSelected = false;
                                isBrightnessSelected = false;
                              });

                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 系统设置
                  Visibility(
                    visible: isSystemSettingSelected,
                    child: Container(
                      width: 80,
                      color: ColorConstant.itemBg,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}aim.png',
                            pressedRes: '${Constant.assetsImg}aim_highlighted.png',
                            content: S.of(context).str_reticle,
                            isSelected: isReticleSelected,
                            onPressed: (){
                              setState(() {
                                isReticleSelected = isReticleSelected ? false : true;
                              });

                            },
                          ),
                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}PIP_checked.png',
                            pressedRes: '${Constant.assetsImg}PIP_checked_h.png',
                            content: S.of(context).str_picture_in_picture,
                            isSelected: isPipSelected,
                            onPressed: (){
                              setState(() {
                                isPipSelected = isPipSelected ? false : true;
                                setPIP(channelNo, isPipSelected ? 1 : 0);
                              });

                            },
                          ),
                          TextImgButton(
                            defaultRes: '${Constant.assetsImg}track.png',
                            pressedRes: '${Constant.assetsImg}track_highlighted.png',
                            content: S.of(context).str_tracking,
                            isSelected: isTrackingSelected,
                            onPressed: (){
                              setState(() {
                                isTrackingSelected = isTrackingSelected ? false : true;
                                setTraceEnable(channelNo, isTrackingSelected ? 1 : 0);
                              });

                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 色板
                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: isRulerSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        height: ScreenUtils.screenH(context),
                        color: ColorConstant.itemBg,
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, i){
                            return RulerColorItem(
                              textColor: indexVale == i ? ColorConstant.themeDark : ColorConstant.theme,
                              imgRes: indexVale == i ? Constant.colorPlateImgListH[i] : Constant.colorPlateImgList[i],
                              index: i,
                              onPressed: (value){
                                setState(() {
                                  indexVale = value;
                                  setPalette(channelNo, value);
                                });
                              },
                            );
                          },
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        ),
                      ),
                    ),
                  ),

                  /// 变倍
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Visibility(
                      visible: isZoomSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtils.screenH(context)*5/4,
                        height: 60,
                        color: ColorConstant.itemBg,
                        child: ControlDeviceRuler(
                          position: zoomPosition,
                          maxNum: zoomMax,
                          minNum: zoomMin,
                          isZoom: true,
                          onPressed: (value){
                            zoomPosition = value;
                            double position = value*100;
                            print('position: $position');
                            setZoom(channelNo, position.toInt());
                          },
                        ),
                      ),
                    ),
                  ),

                  /// 锐度
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: isSharpnessSelected&isImgSettingSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtils.screenH(context)*5/4-60,
                        height: 60,
                        color: ColorConstant.colorTransparent,
                        child: ControlDeviceRuler(
                          position: sharpnessPosition,
                          maxNum: sharpnessMax,
                          minNum: sharpnessMin,
                          isZoom: false,
                          onPressed: (value){
                            sharpnessPosition = value;
                            double position = value*10;
                            setSharpness(channelNo, position.round().toInt());
                          },
                        ),
                      ),
                    ),
                  ),

                  /// 对比度
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: isContrastSelected&isImgSettingSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtils.screenH(context)*5/4-60,
                        height: 60,
                        color: ColorConstant.colorTransparent,
                        child: ControlDeviceRuler(
                          position: contrastPosition,
                          maxNum: contrastMax,
                          minNum: contrastMin,
                          isZoom: false,
                          onPressed: (value){
                            contrastPosition = value;
                            double position = value*10;
                            setContrast(channelNo, position.round().toInt());
                          },
                        ),
                      ),
                    ),
                  ),

                  /// 亮度
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: isBrightnessSelected&isImgSettingSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtils.screenH(context)*5/4-60,
                        height: 60,
                        color: ColorConstant.colorTransparent,
                        child: ControlDeviceRuler(
                          position: brightnessPosition,
                          maxNum: brightnessMax,
                          minNum: brightnessMin,
                          isZoom: false,
                          onPressed: (value){
                            brightnessPosition = value;
                            double position = value*10;
                            setBrightness(channelNo, position.round().toInt());
                          },
                        ),
                      ),
                    ),
                  ),

                  /// 降噪
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: isFilteringSelected&isImgSettingSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtils.screenH(context)*5/4-60,
                        height: 60,
                        color: ColorConstant.colorTransparent,
                        child: ControlDeviceRuler(
                          position: filteringPosition,
                          maxNum: filteringMax,
                          minNum: filteringMin,
                          isZoom: false,
                          onPressed: (value){
                            filteringPosition = value;
                            double position = value*10;
                            setNoiseReduction(channelNo, position.round().toInt());
                          },
                        ),
                      ),
                    ),
                  ),

                  /// 分划
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: isReticleSelected&isSystemSettingSelected,
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenUtils.screenH(context)*5/4-60,
                        height: 60,
                        color: ColorConstant.colorTransparent,
                        child: ControlDeviceRuler(
                          position: reticlePosition,
                          maxNum: reticleMax,
                          minNum: reticleMin,
                          isZoom: false,
                          onPressed: (value){
                            reticlePosition = value;
                            double position = value*10;
                            setReticle(channelNo, position.round().toInt());
                          },
                        ),
                      ),
                    ),
                  ),

                  /// 计时器
                  Align(
                    alignment: Alignment.topCenter,
                    child: Visibility(
                      visible: isVideoSelected&isPlaySelected,
                      child: TextRecordTime(key: fromRecordTime),
                    ),
                  )

                ],
              ),
            ),

            const Spacer(),

            /// 右边菜单
            SizedBox(
              width: 90,
              child: Column(
                children: [
                  ImgButton(
                    defaultRes: '${Constant.assetsImg}config2.png',
                    pressedRes: '${Constant.assetsImg}config2.png',
                    width: 60.0,
                    height: 28.0,
                    onPressed: (){
                      PopListView.showPopWindow(context, '');
                    },
                  ),

                  const Spacer(),

                  MyImgButton(
                    defaultRes: '${Constant.assetsImg}picture.png',
                    pressedRes: '${Constant.assetsImg}picture_highlighted.png',
                    width: 30,
                    isSelected: isPictureSelected,
                    onPressed: (){
                      setState(() {
                        isPictureSelected = true;
                        isVideoSelected = false;
                        isPlaySelected = false;
                      });

                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyImgButton(
                    defaultRes: '${Constant.assetsImg}video.png',
                    pressedRes: '${Constant.assetsImg}video_highlighted.png',
                    width: 35,
                    isSelected: isVideoSelected,
                    onPressed: (){
                      setState(() {
                        isVideoSelected = true;
                        isPictureSelected = false;
                      });

                    },
                  ),

                  const Spacer(),

                  RecordImgButton(
                    defaultRes: '${Constant.assetsImg}play.png',
                    pressedRes: '${Constant.assetsImg}play_highlighted.png',
                    width: 50,
                    isSelected: isPlaySelected,
                    isVideoSelected: isVideoSelected,
                    onPressed: (){
                      setState(() {

                        if(isPictureSelected){
                          isPlaySelected = false;
                          checkPermission(saveAssetsImg(), context);
                        } else {
                          isPlaySelected = isPlaySelected ? false : true;
                          checkPermission(saveVideo(), context);
                        }

                      });

                    },
                  ),

                  const Spacer(),

                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Image.asset('${Constant.assetsImg}ijkImgBtnBg2.png', height: 60,fit: BoxFit.fill,),

                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        child:TextImgButton(
                          defaultRes: '${Constant.assetsImg}ruler.png',
                          pressedRes: '${Constant.assetsImg}ruler_highlighted.png',
                          content: S.of(context).control_right_palette,
                          isSelected: isRulerSelected,
                          onPressed: (){
                            setState(() {
                              isRulerSelected = isRulerSelected ? false : true;
                              isZoomSelected = false;
                              isImgSettingSelected = false;
                              isSystemSettingSelected = false;
                            });

                          },
                        ),
                      ),

                    ],
                  ),

                  const Spacer(),

                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Image.asset('${Constant.assetsImg}ijkImgBtnBg2.png', height: 60,fit: BoxFit.fill,),

                      Container(
                        padding: const EdgeInsets.only(left: 5.0),
                        child:TextImgButton(
                          defaultRes: '${Constant.assetsImg}folder.png',
                          pressedRes: '${Constant.assetsImg}folder_highlighted.png',
                          content: S.of(context).control_right_file,
                          isSelected: isFolderSelected,
                          onPressed: (){
                            setState(() {
                              if(imageList.isEmpty){
                                dirList(IMAGE);
                              }
                              if(videoList.isEmpty){
                                dirList(VIDEO);
                              }
                              MyRouter.pushNoParams(context, MyRouter.pictureAndVideo);
                            });
                          },
                        ),
                      ),

                    ],
                  ),


                  const Spacer(),
                ],
              ),
            ),

          ],
        ),
      ],
    );

  }
}
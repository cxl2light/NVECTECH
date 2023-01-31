import 'package:flutter/material.dart';
import 'package:nvectech/pages/about.dart';
import 'package:nvectech/pages/connected_device.dart';
import 'package:nvectech/pages/control_device_ijk.dart';
import 'package:nvectech/pages/device_info.dart';
import 'package:nvectech/pages/device_introduce.dart';
import 'package:nvectech/pages/notification_home.dart';
import 'package:nvectech/pages/notification_record.dart';
import 'package:nvectech/pages/notification_set.dart';
import 'package:nvectech/pages/picture_and_video.dart';
import 'package:nvectech/pages/picture_detail.dart';
import 'package:nvectech/pages/search_help.dart';
import 'package:nvectech/pages/search_help_detail.dart';
import 'package:nvectech/pages/search_help_device_setting.dart';
import 'package:nvectech/pages/search_help_phone_setting.dart';
import 'package:nvectech/pages/web_view_page.dart';

import 'main.dart';

class MyRouter{
  static const homePage = 'app://';
  static const help = 'app://SearchHelp';
  static const helpDetail = 'app://SearchHelpDetail';
  static const helpSearchPhoneSetting = 'app://HelpSearchPhoneSetting';
  static const helpSearchDeviceSetting = 'app://HelpSearchDeviceSetting';
  static const about = 'app://About';
  static const connectedDevice = 'app://ConnectedDevice';
  static const notification = 'app://NotificationHome';
  static const notificationSet = 'app://NotificationSet';
  static const notificationRecord = 'app://NotificationRecord';
  static const deviceInfo = 'app://DeviceInfo';
  static const deviceIntroduce = 'app://DeviceIntroduce';
  static const controlDeviceIJK = 'app://ControlDeviceIJK';
  static const pictureAndVideo = 'app://PictureAndVideo';
  static const pictureDetail = 'app://PictureDetail';


  Widget _getPage(String url, dynamic params){
    if(url.startsWith('https://') || url.startsWith('http://')){
      return WebViewPage(url: url, title: params);
    } else {
      switch (url) {
        case homePage:
          return const MyApp();
        case help:
          return SearchHelp();
        case helpDetail:
          return SearchHelpDetail(mode: params);
        case helpSearchPhoneSetting:
          return SearchHelpPhoneSetting(imgList: params);
        case helpSearchDeviceSetting:
          return SearchHelpDeviceSetting(imgList: params);
        case about:
          return About();
        case connectedDevice:
          return ConnectedDevice();
        case notification:
          return NotificationHome();
        case notificationSet:
          return NotificationSet();
        case notificationRecord:
          return NotificationRecord();
        case deviceInfo:
          return DeviceInfo();
        case deviceIntroduce:
          return DeviceIntroduce(imgList: params);
        case controlDeviceIJK:
          return ControlDeviceIJK();
        case pictureAndVideo:
          return const PictureAndVideo();
        case pictureDetail:
          return PictureDetail(url: params);

      }
    }

    return const MyApp();
  }

  MyRouter.pushNoParams(BuildContext context, String url){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return _getPage(url, null);
    }));
  }

  MyRouter.push(BuildContext context, String url, dynamic params){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return _getPage(url, params);
    }));
  }
}
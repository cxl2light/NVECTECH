import 'package:flutter/material.dart';
import 'package:nvectech/widgets/text_style_14.dart';

import '../generated/l10n.dart';
import '../utils/sp_util.dart';
Map<String, dynamic>? map;
class ScanConnectDeviceText extends StatefulWidget{

  ScanConnectDeviceText({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _State();
  }

}

class _State extends State<ScanConnectDeviceText>{

  @override
  Widget build(BuildContext context) {
    map = SPUtil().getJson(SPUtil.deviceInfo);
    return TextStyle14(
      content: map==null?S.of(context).scan_device:S.of(context).connect_device,
    );
  }
}
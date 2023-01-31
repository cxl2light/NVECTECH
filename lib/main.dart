import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nvectech/native_add_test.dart';
import 'package:nvectech/widgets/scan_connect_device_text.dart';
import 'package:package_info/package_info.dart';
import 'package:nvectech/constant/color_constant.dart';
import 'package:nvectech/constant/constant.dart';
import 'package:nvectech/net/webview_js.dart';
import 'package:nvectech/pages/pop_list_view.dart';
import 'package:nvectech/pages/pop_view_dialog.dart';
import 'package:nvectech/pages/search_result.dart';
import 'package:nvectech/router.dart';
import 'package:nvectech/sqflite/sqf_lite_queue_data.dart';
import 'package:nvectech/utils/sp_util.dart';
import 'package:nvectech/widgets/img_button.dart';
import 'package:nvectech/widgets/loading_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plugins/plugins.dart';


import 'generated/l10n.dart';

bool showSearchResult = false;
String _networkInterface = '';
late Timer _timer;
int handle = -1;
late String testPath;
String VIDEO = 'videos';
String ip = 'rtsp://192.168.1.73:554/mainstream';
bool isRecording = false;

GlobalKey fromScanDevice = GlobalKey();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SPUtil?>(
      future: SPUtil.perInit(),
      builder: (BuildContext context, AsyncSnapshot<SPUtil?> snapshot){
        Widget widget = snapshot.connectionState == ConnectionState.done
            ? const HomePage()
            : const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
        return MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          localeListResolutionCallback: (locales, supportedLocales){
            setVersion();
            print('language：$locales');
            return;
          },
          theme: ThemeData(fontFamily: 'Exo2'),
          home: widget,
        );
      },
    );

  }

  void setVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SPUtil().setString(SPUtil.version, packageInfo.version);
  }
}

class HomePage extends StatefulWidget{
  const HomePage({Key? key}):super(key:key);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    SqfLiteQueueData.internal();
    getIP();
    // initFfmpegSdk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Constant.backgroundImg),
          ),
        ),

        child: Column(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 186,
                height: 35,
                margin: const EdgeInsets.only(top: 30.0, right: 30.0),
                child: GestureDetector(
                  onTap: (){
                        PopViewDialog.showPopWindow(context, S.of(context).select_hint, S.of(context).base_yes, S.of(context).base_no,
                                (index){
                              Navigator.pop(context);
                              if(index == 0){
                                MyRouter.pushNoParams(context, MyRouter.help);
                              } else if( index == 1){
                                getDeviceList(context);
                              }
                            });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('${Constant.assetsImg}searchConnectDevice.png'),
                      ),
                    ),
                    child: ScanConnectDeviceText(
                      key: fromScanDevice,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 30.0, bottom: 30.0),
                child: ImgButton(
                  defaultRes: '${Constant.assetsImg}config.png',
                  pressedRes: '${Constant.assetsImg}config.png',
                  width: 20.0,
                  height: 20.0,
                  onPressed: (){
                    PopListView.showPopWindow(context, Constant.mainFlag);
                  },
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    SPUtil().remove(SPUtil.deviceInfo);
    // SPUtil().remove(SPUtil.newRealHandle);
    super.dispose();
  }

  static getDeviceList(BuildContext context) async{
    print('getDeviceList');
    Plugins.callJavaMethod();
    // print('1+2=${expAdd(1,2)}');
    // print('result=${initNetCore()}');
    //
    // Pointer<Int8> nativeValue = '192.168.22.126'.toNativeUtf8().cast<Int8>();
    // print('netCoreLogin=${netCoreLogin(nativeValue, 45000)}');

    try{
      if(_networkInterface.isNotEmpty && _networkInterface.contains('.')){
        List<String> ipArr = _networkInterface.split('.');
        if(ipArr.length !=4)return;
        String ip = '${ipArr[0]}.${ipArr[1]}.${ipArr[2]}.';
        showSearchResult = false;
        WebViewJS.callJs(context, ip, (value){
          print('getDeviceList value: $value');
          List list = jsonDecode(value.toString());
          SPUtil().setJson(SPUtil.deviceInfo, list[0]);
          SPUtil().setString(SPUtil.searchResult, value);
          if(_timer.isActive){
            showSearchResult = true;
          } else{
            SearchResult.showPopWindow(context);
          }
        });
      } else {
        print('IP is empty!');
        return;
      }
    } catch (e){
      print('Catch DioError');
    }

    Navigator.push(context, PopRoute(child: LoadingWidget.getLoading(backgroundColor: ColorConstant.colorHalfTransparent, loadingBgColor: ColorConstant.colorTransparent)));
    _timer = Timer.periodic(const Duration(milliseconds: 4000), (timer) {
      Navigator.pop(context);
      Navigator.pop(context);
      _timer.cancel();
      if(showSearchResult){
        SearchResult.showPopWindow(context);
      }
    });
  }

  void getIP() {
    NetworkInterface.list(includeLoopback: false, type: InternetAddressType.any)
        .then((List<NetworkInterface> interfaces) {
      setState( () {
        _networkInterface = "";
        // interfaces: [NetworkInterface('en0', [InternetAddress('192.168.1.158', IPv4)])]
        if(interfaces.isEmpty)return;
        for (var address in interfaces) {
          _networkInterface = address.addresses.toString();
          if(_networkInterface.contains('IPv4')){
            _networkInterface = address.addresses[0].address;
            print('IP: $_networkInterface');
            return;
          }
        }
      });
    });
  }


  /// 创建文件目录
  createDirTest(String fileName) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    testPath = '${documentsDirectory.path}${Platform.pathSeparator}$fileName';
    var dir = Directory(testPath);
    var exist = dir.existsSync();
    if (exist) {
      print('当前文件夹已经存在');
    } else {
      var result = await dir.create();
      print('$result');
    }
  }

}


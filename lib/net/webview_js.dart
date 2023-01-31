import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constant/color_constant.dart';

String jsPath = 'assets/html/jquery.min.js';
String htmlPath = 'assets/html/FlutterCallJS.html';

typedef VoidCallback = void Function(dynamic value);
class WebViewJS extends StatefulWidget{
  final String deviceIp;
  final VoidCallback result;
  WebViewJS({Key? key, required this.deviceIp, required this.result}) : super(key: key);

  static void callJs(context, deviceIp, result){
    Navigator.push(
        context,
        CallJsResult(
            child: WebViewJS(deviceIp: deviceIp, result: result)
        )
    );
  }

  @override
  State<StatefulWidget> createState() => _State();

}

class CallJsResult extends PopupRoute {
  Widget child;

  CallJsResult({required this.child});

  @override
  Color? get barrierColor => ColorConstant.colorTransparent;

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => 'label';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}

class _State extends State<WebViewJS> {
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return WebView(
      backgroundColor: ColorConstant.colorTransparent,
      javascriptMode: JavascriptMode.unrestricted,
      gestureNavigationEnabled: true,
      navigationDelegate: (NavigationRequest request) {
        return NavigationDecision.navigate;
      },
      onPageFinished: (url) async{
        //加载js文件
        String jsContent = await rootBundle.loadString(jsPath);
        _webViewController.runJavascript(jsContent);

        for(int i = 2; i < 255; i++){
          _webViewController.runJavascript("loadData('${widget.deviceIp}$i')");
        }

      },
      onWebViewCreated: (controller){
        _webViewController = controller;
        _loadHtmlFromAssets();
      },
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(
            name: "MessageDeal",
            onMessageReceived: (JavascriptMessage message) {
              // 这里接收到的就是 js 中发送过来的message。 和js里MessageDeal.postMessage(message) 中的message 对应 。
              // 可以根据message来做一些相应的处理
              widget.result(message.message);
            }),
      },
    );
  }

  _loadHtmlFromAssets() async {

    String fileHtmlContents = await rootBundle.loadString(htmlPath);

    _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString());

    String jsContent = await rootBundle.loadString(jsPath);
    _webViewController.runJavascript(jsContent);

  }

}
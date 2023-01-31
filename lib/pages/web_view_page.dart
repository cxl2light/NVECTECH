import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 网页显示
class WebViewPage extends StatelessWidget{
  final String url;
  final String title;

  const WebViewPage({Key? key, required this.url, required this.title}):super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller){
          print('onWebViewCreated');
        },
        onPageStarted: (url){
          print('onPageStarted');

        },
        onPageFinished: (url){
          print('onPageFinished');
        },
        onWebResourceError: (WebResourceError error){
          print('onWebResourceError: ${error.description}');
        },
      ),
    );
  }

}
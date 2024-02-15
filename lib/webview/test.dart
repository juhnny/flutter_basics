import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 안드로이드에서 minSdkVersion 19 이상으로 설정 필요

void main(){
  runApp(MyWebView());
}

class MyWebView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(Color(0x00000000))
      // NavigationDelegate를 통해 웹뷰 내 페이지 이동 트래킹 가능
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progresss) {
            // Update loading bar.
          },
          onUrlChange: (UrlChange change){
            debugPrint('url change to ${change.url}');
          },
          onPageStarted: (String url) {
            debugPrint('url started: $url');
          },
          onPageFinished: (String url) {
            debugPrint('url finished: $url');
          },
          onWebResourceError: (WebResourceError error) {},
          // 페이지 이동을 허가하거나 막을 수 있다.
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..loadRequest(Uri.parse('https://flutter.dev'));
      // ..loadRequest(Uri.parse('https://pildservice.com'));
      ..loadRequest(Uri.parse('https://map.naver.com'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }

}
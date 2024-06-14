// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(
    const GetMaterialApp(
      home: KakaoMap(),
    ),
  );
}

class KakaoMap extends StatefulWidget {
  const KakaoMap({Key? key}) : super(key: key);

  @override
  _KakaoMapState createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    permission();
  }

  Future<void> permission() async {
    // Map<Permission, PermissionStatus> statuses =
    await [Permission.camera, Permission.storage].request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('eagohri'),
              _webview(),
            ],
          ),
        ),
      ),
    );
  }

  void Function(JavascriptMessage)? onTapMarker;

  Widget _webview() {
    return SizedBox(
      height: 600,
      width: 400,
      child: WebView(
        // initialUrl: 'http://127.0.0.1:5500/kakaomap.html',
        // initialUrl: 'https://www.naver.com',
        // initialUrl: 'https://foreverspring98.com/kakaomap.html',
        initialUrl: 'https://muhanface.netlify.app',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          JavascriptChannel(
              name: 'onTapMarker',
              onMessageReceived: (message) {
                print(message.message);
              }),
          JavascriptChannel(
              name: 'mouseTouch',
              onMessageReceived: (message) {
                print(message.message);
              }),
        },
        debuggingEnabled: true,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
          Factory(() => EagerGestureRecognizer()),
        },
      ),
    );
  }
}

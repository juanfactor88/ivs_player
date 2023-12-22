
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IvsPlayerController {
  final MethodChannel _channel = const MethodChannel('com.example.ivs_player');
  final int viewId = 0;
  Function(String)? onErrorCallback;

  IvsPlayerController() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<void> play(String url) async {
     if (Platform.isAndroid) {
    await _channel.invokeMethod('play', {'url': url, 'viewId': viewId});
  } else if (Platform.isIOS) {
    await _channel.invokeMethod('play', {'url': url});
  }
  }

    Future<void> dispose() async {
      if (Platform.isAndroid) {
    await _channel.invokeMethod('dispose', {'viewId': viewId});
  } else if (Platform.isIOS) {
    await _channel.invokeMethod('dispose');
  }
  }

  void setOnErrorCallback(Function(String) callback) {
    onErrorCallback = callback;
  }

  Future<void> _handleMethodCall(MethodCall call) async {
    if (call.method == "onPlayerError") {
      var errorCode = call.arguments["errorCode"];
      var errorMessage = call.arguments["errorMessage"];
      print("----------------  $errorMessage  ---------------");
      onErrorCallback?.call(errorMessage);

    }
  }
}

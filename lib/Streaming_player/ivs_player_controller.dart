
import 'package:flutter/services.dart';

class IvsPlayerController {
  static const MethodChannel _channel = MethodChannel('com.example.ivs_player');

  Future<void> play(String url) async {
    await _channel.invokeMethod('play', {'url': url});
  }

    Future<void> dispose() async {
    await _channel.invokeMethod('dispose');
  }
}

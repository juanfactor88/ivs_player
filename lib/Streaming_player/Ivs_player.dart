import 'package:flutter/material.dart';
import 'dart:io';

import 'package:ivs_player/Streaming_player/ivs_player_controller.dart';

class IvsVideoPlayer extends StatelessWidget {
  final Map<String, dynamic> creationParams = <String, dynamic>{};
  final String viewType = '<platform-view-type>';


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Example height
      width: 500, // Example width
      child: Platform.isIOS ? UiKitView(
        viewType: 'ivs_player_view',
        onPlatformViewCreated: _onPlatformViewCreated,
      ) : AndroidView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
      ),
    );
  }

  void _onPlatformViewCreated(int id) {

  }
}
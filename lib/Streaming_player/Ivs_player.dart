import 'package:flutter/material.dart';
import 'dart:io';

class IvsVideoPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Example height
      width: 500, // Example width
      child: Platform.isIOS ? UiKitView(
        viewType: 'ivs_player_view',
        onPlatformViewCreated: _onPlatformViewCreated,
      ) : AndroidView(
        viewType: 'ivs_player_view',
        onPlatformViewCreated: _onPlatformViewCreated,
      ),
    );
  }

  void _onPlatformViewCreated(int id) {
    // Platform view created logic
  }
}
package com.example.ivs_player

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log




class MainActivity : FlutterActivity() {
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("<platform-view-type>", NativeViewFactory(flutterEngine.dartExecutor.binaryMessenger))

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.ivs_player")
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "play" -> {
                    Log.d("MainActivity", "Play method called")
                    val url = call.argument<String>("url")
                    val viewId = call.argument<Int>("viewId")
                    val nativeView = NativeViewFactory.viewMap[viewId]
                    if (url != null && nativeView != null) {
                        nativeView.play(url)
                        Log.d("MainActivity", "NativeView found and play called")
                        result.success(null)
                    } else {
                        Log.d("MainActivity", "NativeView not found or URL is null")
                        result.error("ERROR", "URL or NativeView is null", null)
                    }
                }
                "dispose" -> {
                    val viewId = call.argument<Int>("viewId")
                    NativeViewFactory.viewMap[viewId]?.dispose()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}

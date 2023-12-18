package com.example.ivs_player

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.ivs_player.NativeViewFactory
import android.util.Log
import com.example.ivs_player.NativeViewFactory.Companion.viewMap



class MainActivity : FlutterActivity() {
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine
                .platformViewsController
                .registry
                .registerViewFactory("<platform-view-type>",
                                      NativeViewFactory())

        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.example.ivs_player")
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method)  {
                "play" -> {
                    val url = call.argument<String>("url")
                    val viewId = call.argument<Int>("viewId")
                     if (url != null && viewId != null) {
                      //  viewMap[viewId]?.play(url)
                        result.success(null)
                    } else {
                        // Handle the case where url or viewId is null
                        result.error("ERROR", "URL or ViewID is null", null)
                    }
                }
                "dispose" -> {
                    val viewId = call.argument<Int>("viewId") // Ensure 'viewId' is sent from Flutter

                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}

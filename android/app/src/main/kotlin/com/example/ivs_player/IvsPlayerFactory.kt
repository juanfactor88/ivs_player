package com.example.ivs_player


import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import io.flutter.plugin.common.BinaryMessenger
import android.util.Log


class NativeViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    companion object {
        val viewMap = mutableMapOf<Int, NativeView>()
    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val nativeView = NativeView(context, viewId, args as Map<String?, Any?>?)
        viewMap[viewId] = nativeView
        Log.d("NativeViewFactory", "Stored NativeView with ID: $viewId")
        return nativeView
    }

}


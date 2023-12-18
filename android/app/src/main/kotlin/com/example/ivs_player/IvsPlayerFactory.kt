package com.example.ivs_player


import android.content.Context
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    companion object {
        val viewMap = mutableMapOf<Int, NativeView>()

    }

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val nativeView = NativeView(context, viewId, args as Map<String?, Any?>?)
        viewMap[viewId] = nativeView
        return nativeView
    }
}


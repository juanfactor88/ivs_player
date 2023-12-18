package com.example.ivs_player


import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import com.amazonaws.ivs.player.*
import android.net.Uri
import android.util.Log


import io.flutter.plugin.platform.PlatformView

class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val playerView: PlayerView = PlayerView(context)

    override fun getView(): View = playerView

    override fun dispose() {
        playerView.player.pause()
        //playerView.player.release()
    }

    fun play(url: String) {
        Log.d("NativeView", "Playing URL: $url")
        playerView.player.load(Uri.parse(url))
    }

    init {
        playerView.setControlsEnabled(false)
    }
}

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
    private val playerView: PlayerView

    override fun getView(): View {
        return playerView
    }

    override fun dispose() {
        playerView.player.release()
    }

    fun play(url: String) {
        Log.d("NativeView", "Playing URL: $url")
        playerView.player.load(Uri.parse(url))
    }

    init {
        playerView = PlayerView(context)
        playerView.setControlsEnabled(false)
        playerView.player.load(Uri.parse("https://fcc3ddae59ed.us-west-2.playback.live-video.net/api/video/v1/us-west-2.893648527354.channel.DmumNckWFTqz.m3u8"))
    }
}

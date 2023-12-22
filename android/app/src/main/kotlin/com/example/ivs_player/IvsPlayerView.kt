package com.example.ivs_player


import android.content.Context
import android.net.Uri
import android.util.Log
import android.view.View
import com.amazonaws.ivs.player.*
import io.flutter.plugin.platform.PlatformView
import java.nio.ByteBuffer


interface PlayerErrorListener {
    fun onError(errorCode: String, errorMessage: String)
}

class NativeView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
    private val playerView: PlayerView = PlayerView(context)
    lateinit var player: Player
    var errorListener: PlayerErrorListener? = null

    override fun getView(): View = playerView

    init {
        playerView.setControlsEnabled(false)
        player = playerView.getPlayer()

        player.setAutoQualityMode(true)
        player.setLiveLowLatencyEnabled(true)
        player.setRebufferToLive(true)
        player.setVolume(1.0f)
        handlePlayerEvents()

    }

    override fun dispose() {
        player.pause()

    }

    fun play(url: String) {
        Log.d("NativeView", "Playing URL: $url")
        player.load(Uri.parse(url))
    }

    fun handlePlayerEvents (){
        player.addListener(object : Player.Listener() {
            override fun onNetworkUnavailable(){
                Log.d("StreamingNetwork", "error: ---------           There is no network -----------------$")
                errorListener?.onError("000", "network not available")

            }

            override fun onError(p0: PlayerException) {
                // Handle the error and send a message to Flutter
                Log.d("PlayerState", "error: $p0")
                val errorCode = "Error Code" // Or any other appropriate default/error code
                val errorMessage = p0.message ?: "Unknown error"
                errorListener?.onError(errorCode, errorMessage)
            }
            override fun onAnalyticsEvent(p0: String, p1: String) {
                // Implement if needed
            }
            override fun onDurationChanged(p0: Long) {
                // Implement if needed
            }
            override fun onMetadata(type: String, data: ByteBuffer) {
                // Implement if needed
            }
            override fun onQualityChanged(p0: Quality) {
                // Implement if needed
            }
            override fun onRebuffering() {
                // Implement if needed
            }
            override fun onSeekCompleted(p0: Long) {
                // Implement if needed
            }

            override fun onVideoSizeChanged(p0: Int, p1: Int) {
                // Implement if needed
            }
            override fun onCue(cue: Cue) {
                // Implement if needed
                // For example:
                when (cue) {
                    is TextMetadataCue -> Log.i("IVSPlayer","Received Text Metadata: ${cue.text}")
                    // Handle other cue types if needed
                }
            }

            override fun onStateChanged(state: Player.State) {
                Log.i("PlayerLog", "Current state: ${state}")
                when (state) {
                    Player.State.BUFFERING,
                    Player.State.READY -> {
                        // updateQuality()
                    }
                    Player.State.IDLE,
                    Player.State.ENDED -> {
                        // no-op
                    }
                    Player.State.PLAYING -> {
                        // Qualities will be dependent on the video loaded, and can
                        // be retrieved from the player
                        Log.i("IVS Player Status", "playing")
                    }
                }
            }
        })
    }


    }


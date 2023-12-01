import UIKit
import AmazonIVSPlayer
import Flutter

class IVSPlayerFlutterView: NSObject, FlutterPlatformView {
    private var player: IVSPlayer
    private var ivsPlayerView: IVSPlayerView

    init(frame: CGRect, viewId: Int64, args: Any?) {
        self.player = IVSPlayer()
        self.ivsPlayerView = IVSPlayerView(frame: frame)
        super.init()
        self.ivsPlayerView.player = player
        setupPlayer()
    }

    func view() -> UIView {
        return ivsPlayerView
    }

    private func setupPlayer() {
        // Load and play the stream URL as needed
        if let url = URL(string: "https://33faec3073fe.us-east-1.playback.live-video.net/api/video/v1/us-east-1.289878084237.channel.OxyyPc1cDznX.m3u8") {
            player.load(url)
        }
    }
}

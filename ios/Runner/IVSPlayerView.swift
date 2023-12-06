import UIKit
import AmazonIVSPlayer
import Flutter

class IVSPlayerFlutterView: NSObject, FlutterPlatformView, IVSPlayer.Delegate {
    private var player: IVSPlayer
    private var ivsPlayerView: IVSPlayerView

    init(frame: CGRect, viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        self.player = IVSPlayer()
        self.ivsPlayerView = IVSPlayerView(frame: frame)
        super.init()
        self.ivsPlayerView.player = player
        self.player.delegate = self
        setupIVSPlayerView()
    }

    func view() -> UIView {
        return ivsPlayerView
    }

    private func setupIVSPlayerView() {
        ivsPlayerView.backgroundColor = UIColor.black
          if let url = URL(string: "https://cph-p2p-msl.akamaized.net/hls/live/2000341/test/master.m3u8") {
            player.load(url)
        }
        // Additional setup for IVSPlayer, if necessary
    }

    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        print("Player state changed to: \(state)")
        if state == .ready {
            player.play()
        }
        // Implement other delegate methods for error handling, etc.
    }
}
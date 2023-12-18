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

         // Escuchar la notificación
        NotificationCenter.default.addObserver(self, selector: #selector(streamLoaded), name: NSNotification.Name("StreamLoaded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopStream), name: NSNotification.Name("StopStream"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func streamLoaded(notification: Notification) {
        DispatchQueue.main.async {
            if let url = notification.userInfo?["url"] as? URL {
                self.player.load(url)
            }
        }
    }

    @objc func stopStream() {
        DispatchQueue.main.async {
            self.player.pause()
        }
    }

    func view() -> UIView {
        return ivsPlayerView
    }

    private func setupIVSPlayerView() {
        ivsPlayerView.backgroundColor = UIColor.black

    }

    func player(_ player: IVSPlayer, didChangeState state: IVSPlayer.State) {
        print("Player state changed to: \(state)")
        if state == .ready {
            player.play()
        }
        // Implement other delegate methods for error handling, etc.
    }
}
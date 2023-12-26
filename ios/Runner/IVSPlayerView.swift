import UIKit
import AmazonIVSPlayer
import Flutter
import Network


class IVSPlayerFlutterView: NSObject, FlutterPlatformView, IVSPlayer.Delegate {
    private var player: IVSPlayer
    private var ivsPlayerView: IVSPlayerView
    private let networkMonitor = NWPathMonitor()
    private var isNetworkAvailable = true
    private var channel: FlutterMethodChannel

    init(frame: CGRect, viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        self.player = IVSPlayer()
        self.ivsPlayerView = IVSPlayerView(frame: frame)
        self.channel = FlutterMethodChannel(name: "com.example.ivs_player", binaryMessenger: messenger!)  // Initialize the MethodChannel

        super.init()
        setupNetworkMonitor()
        self.ivsPlayerView.player = player
        self.player.setNetworkRecoveryMode(IVSPlayer.NetworkRecoveryMode.resume)
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
//player.setNetworkRecoveryMode(IVSPlayer.NetworkRecoveryMode.resume)
            player.play()
        }
    /*    else if isNetworkAvailable == false{
            self.channel.invokeMethod("onPlayerError", arguments: ["errorCode": 000, "errorMessage": "Network not available"])
        }*/

        // Implement other delegate methods for error handling, etc.
    }
    
    func player(_ player: IVSPlayer, didFailWithError error: Error) {
        print("Player error occurred: \(error.localizedDescription)")
        let nsError = error as NSError
        let errorCode = nsError.code
        let errorMessage = nsError.localizedDescription
        self.channel.invokeMethod("onPlayerError", arguments: ["errorCode": errorCode, "errorMessage": errorMessage])
      }
    
    private func setupNetworkMonitor() {
         networkMonitor.pathUpdateHandler = { [weak self] path in
             DispatchQueue.main.async {
                 if path.status == .satisfied {
                     print("Network connection is available.")
                     self?.isNetworkAvailable = true
                    // self?.resumePlaybackIfNeeded()
                 } else {
                     print("Network connection is lost.")
                     self?.isNetworkAvailable = false
                 }
             }
         }
         let queue = DispatchQueue(label: "NetworkMonitor")
         networkMonitor.start(queue: queue)
     }
    
    private func resumePlaybackIfNeeded() {
            if isNetworkAvailable && player.state == .idle {
                player.play()
            }
        }
 
    
}

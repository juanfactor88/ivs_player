import Foundation
import AmazonIVSPlayer

class IVSPlayerManager {
    var player: IVSPlayer?

    init() {
        player = IVSPlayer()
    }

    func play(url: String) {
        guard let streamURL = URL(string: url) else {
            print("Invalid URL")
            return
        }
        player?.load(streamURL)
        player?.play()
    }

    func dispose() {
        player?.pause()
        player = nil
    }
}

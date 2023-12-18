import Foundation
import AmazonIVSPlayer

class IVSPlayerManager {
    var player: IVSPlayer?

    init() {
       // player = IVSPlayer()
    }

    func play(url: String) {
        //player = IVSPlayer()
        guard let streamURL = URL(string: url) else {
            print("Invalid URL")
            return
        }
        //player?.load(streamURL)
        //player?.play()

        // Se añade un callback para indicar que el stream se ha cargado y asi saber cuando refrescar la vista
        NotificationCenter.default.post(name: NSNotification.Name("StreamLoaded"), object: nil, userInfo: ["url": streamURL])
     }
    

    func dispose() {
        //player?.pause()
        //player = nil
        NotificationCenter.default.post(name: NSNotification.Name("StopStream"), object: nil)
     }
   
}


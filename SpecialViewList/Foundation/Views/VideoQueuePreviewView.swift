import UIKit
import AVKit

class VideoQueuePreviewView: UIView {

    private var player: AVPlayer? {
        get { playerLayer.player }
        set { playerLayer.player = newValue }
    }
    
    private var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    func setupPlayer(
        videoQueuePlayer: VideoQueuePlayer
    ) {
        self.player = videoQueuePlayer.player
        playerLayer.videoGravity = .resizeAspectFill
    }
}

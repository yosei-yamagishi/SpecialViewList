import UIKit
import AVKit

class VideoPreviewView: UIView, NibOwnerLoadable {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setupPlayer(
        avPlayer: AVPlayer?
    ) {
        self.player = avPlayer
        playerLayer.videoGravity = .resizeAspectFill
    }
    
    func removePlayer() {
        self.player = nil
    }
}

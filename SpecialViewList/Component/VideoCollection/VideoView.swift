import UIKit
import AVKit

class VideoView: UIView, NibOwnerLoadable {

    @IBOutlet weak var videoPreviewView: VideoPreviewView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setupPlayer(avPlayer: AVPlayer?) {
        videoPreviewView.setupPlayer(avPlayer: avPlayer)
    }
    
    func removePlayer() {
        videoPreviewView.removePlayer()
    }

    func setupThumbnailImage(urlString: String) {
        thumbnailImageView.image = UIImage(named: urlString)
    }
}

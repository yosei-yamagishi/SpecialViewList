import UIKit
import AVKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removePlayer()
        videoView.resetImage()
    }

    @IBOutlet weak var videoView: VideoView!
    
    func setupPlayer(avPlayer: AVPlayer?) {
        videoView.setupPlayer(avPlayer: avPlayer)
    }
    
    func removePlayer() {
        videoView.resetPlayer()
    }

    func setupThumbnailImage(urlString: String) {
        videoView.setupThumbnailImage(urlString: urlString)
    }
}

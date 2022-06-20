import UIKit
import AVKit

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoView: VideoView!
    
    func setupPlayer(avPlayer: AVPlayer?) {
        videoView.setupPlayer(avPlayer: avPlayer)
    }
    
    func removePlayer() {
        videoView.removePlayer()
    }

    func setupThumbnailImage(urlString: String) {
        videoView.setupThumbnailImage(urlString: urlString)
    }
}

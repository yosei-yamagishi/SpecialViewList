import UIKit

class VideoPreviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerViewControllerView: AVPlayerViewControllerView! {
        didSet {
            playerViewControllerView.setupPlayerView()
        }
    }
    
    func setupPlayer(videoPlayer: VideoPlayerProtocol) {
        playerViewControllerView.setPlayer(
            player: videoPlayer.player
        )
    }
}

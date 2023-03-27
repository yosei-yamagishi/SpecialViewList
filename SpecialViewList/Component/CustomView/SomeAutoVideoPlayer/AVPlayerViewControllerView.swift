import UIKit
import AVKit

class AVPlayerViewControllerView: UIView, NibOwnerLoadable {
    @IBOutlet weak var playerView: UIView!
    
    var playerController = AVPlayerViewController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setPlayer(player: AVPlayer?) {
        playerController.player = player
    }
    
    func setupPlayerView() {
        playerController.view.frame = CGRect(
            origin: .zero,
            size: playerView.frame.size
        )
        playerView.addSubview(playerController.view)
    }
}

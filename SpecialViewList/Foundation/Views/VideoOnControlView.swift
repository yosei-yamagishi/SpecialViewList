import UIKit

class VideoOnControlView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var videoView: VideoQueuePreviewView!
    @IBOutlet weak var videoControlView: VideoControlView!
    
    weak var controlDelegate: VideoControlViewDelegate? {
        didSet {
            videoControlView.delegate = controlDelegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setupPlayer(videoQueuePlayer: VideoQueuePlayer) {
        videoView.setupPlayer(
            videoQueuePlayer: videoQueuePlayer
        )
    }
    
    func setCurrentTime(currentTime: Float) {
        videoControlView.setCurrentTime(
            currentTime: currentTime
        )
    }
    
    func setTotalTime(totalTime: Float) {
        videoControlView.setSeekBar(totalTime: totalTime)
    }
}

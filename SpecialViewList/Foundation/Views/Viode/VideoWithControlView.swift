import UIKit
import AVFoundation

class VideoWithControlView: UIView, NibOwnerLoadable {
    @IBOutlet weak var playerView: VideoView!
    @IBOutlet weak var controlView: VideoControlView!
    
    private var controlViewHiddenTimer: Timer?

    var controlDelegate: VideoControlDelegate? {
        get { controlView.delegate }
        set { controlView.delegate = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    func setupPlayer(avPlayer: AVPlayer?) {
        playerView.setupPlayer(avPlayer: avPlayer)
    }

    func switchPlayAndPauseButton(isPlaying: Bool) {
        controlView.switchPlayAndPauseButton(
            isPlaying: isPlaying
        )
    }

    func setCurrentTime(currentTime: Float) {
        controlView.setCurrentTime(
            currentTime: currentTime
        )
    }

    func setDuration(duration: Float) {
        controlView.setDuration(
            duration: duration
        )
    }

    func switchDisplayControlView(isHidden: Bool) {
        controlView.isHidden = isHidden
    }

    func switchFullScreenButton(
        isFullScreen: Bool
    ) {
        controlView.switchFullScreenButton(
            isFullScreen: isFullScreen
        )
    }

    func resetPlayer() {
        playerView.resetPlayer()
    }
    
    func updateImage(image: UIImage?) {
        controlView.updateThumbnailImage(image: image)
    }
    
    func setupSpeedButton(
        currentSpeed: Double,
        speeds: [Double]
    ) {
        controlView.setupSpeedButton(
            currentSpeed: currentSpeed,
            speeds: speeds
        )
    }
}

extension VideoWithControlView {
    func activateControlViewHiddenTimer() {
        controlViewHiddenTimer = Timer.scheduledTimer(
            withTimeInterval: 5.0,
            repeats: false
        ) { [weak self] _ in
            self?.controlView.isHiddenControlView = true
        }
    }

    func deactivateControlViewHiddenTimer() {
        controlViewHiddenTimer?.invalidate()
        controlViewHiddenTimer = nil
    }
}

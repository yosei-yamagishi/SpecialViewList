import UIKit

protocol VideoControlDelegate: AnyObject {
    func didTapPlayAndPause()
    func didTapForward()
    func didTapBackward()
    func didTapFullScreen()
    func didTapSpeedRate(speed: Double)
    func didTapDownSeekBar(currentTime: Float)
    func didTapUpInsideOrOutsideSeekBar(currentTime: Float)
    func didTapSeekBar(currentTime: Float)
    func didChangedPlayTime(currentTime: Float)
}

final class VideoControlView: UIView, NibOwnerLoadable {
    @IBOutlet weak var playerControllerStackView: UIStackView!
    @IBOutlet weak var playerInfoView: UIView!
    @IBOutlet weak var playerBackgroundView: UIView!
    @IBOutlet weak var controlBackgroundButton: UIButton! {
        didSet {
            controlBackgroundButton.addAction(
                UIAction { [weak self] _ in
                    self?.isHiddenControlView.toggle()
                },
                for: .touchUpInside
            )
        }
    }

    @IBOutlet weak var playAndPauseButton: UIButton! {
        didSet {
            playAndPauseButton.setImage(
                UIImage.sfsymbolImage(
                    sfsymbolType: .pauseFill,
                    pointSize: 56
                ),
                for: .normal
            )
            playAndPauseButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapPlayAndPause()
                },
                for: .touchUpInside
            )
        }
    }

    @IBOutlet weak var forwardSkipButton: UIButton! {
        didSet {
            forwardSkipButton.setImage(
                UIImage.sfsymbolImage(
                    sfsymbolType: .goforward10,
                    pointSize: 44
                ),
                for: .normal
            )
            forwardSkipButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapForward()
                },
                for: .touchUpInside
            )
        }
    }

    @IBOutlet weak var backwardSkipButton: UIButton! {
        didSet {
            backwardSkipButton.setImage(
                UIImage.sfsymbolImage(
                    sfsymbolType: .gobackward10,
                    pointSize: 44
                ),
                for: .normal
            )
            backwardSkipButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapBackward()
                },
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var subtitleButton: UIButton! {
        didSet {
            subtitleButton.setImage(
                UIImage.sfsymbolImage(
                    sfsymbolType: .captionsBubble,
                    pointSize: 24
                ),
                for: .normal
            )
        }
    }
    
    @IBOutlet weak var videoPlaybackRateButton: UIButton! {
        didSet {
            videoPlaybackRateButton.setImage(
                UIImage.sfsymbolImage(
                    sfsymbolType: .gaugeWithDotsNeedle67percent,
                    pointSize: 24
                ),
                for: .normal
            )
        }
    }

    @IBOutlet weak var fullScreenButton: UIButton! {
        didSet {
            fullScreenButton.setImage(
                UIImage.sfsymbolImage(
                    sfsymbolType: .fullScreen,
                    pointSize: 24
                ),
                for: .normal
            )
            fullScreenButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapFullScreen()
                },
                for: .touchUpInside
            )
        }
    }

    @IBOutlet weak var currentTimeLabel: UILabel! {
        didSet {
            currentTimeLabel.textColor = .white
        }
    }

    @IBOutlet weak var durationTimeLabel: UILabel! {
        didSet {
            durationTimeLabel.textColor = .white
        }
    }

    @IBOutlet weak var thumbnailImageBaseView: UIView! {
        didSet {
            thumbnailImageBaseView.isHidden = true
        }
    }
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var seekBarSlider: UISlider! {
        didSet {
            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self,
                          let slider = action.sender as? UISlider
                    else { return }
                    self.updateThumbnailImagePoint(slider: slider)
                    self.setCurrentTime(
                        currentTime: slider.value
                    )
                    self.delegate?.didChangedPlayTime(currentTime: slider.value)
                },
                for: .valueChanged
            )

            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self,
                          let slider = action.sender as? UISlider
                    else { return }
                    self.playerControllerStackView.fadeOut()
                    self.thumbnailImageBaseView.fadeIn()
                    self.delegate?.didTapDownSeekBar(
                        currentTime: slider.value
                    )
                },
                for: .touchDown
            )

            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self,
                          let slider = action.sender as? UISlider
                    else { return }
                    self.playerControllerStackView.fadeIn()
                    self.thumbnailImageBaseView.fadeOut()
                    self.delegate?.didTapUpInsideOrOutsideSeekBar(
                        currentTime: slider.value
                    )
                },
                for: .touchUpInside
            )

            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self,
                          let slider = action.sender as? UISlider
                    else { return }
                    self.delegate?.didTapUpInsideOrOutsideSeekBar(
                        currentTime: slider.value
                    )
                },
                for: .touchUpOutside
            )

            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(skipTimeToPosision)
            )
            seekBarSlider.addGestureRecognizer(tapGesture)
        }
    }
    
    private func updateThumbnailImagePoint(slider: UISlider) {
         let trackRect = slider.trackRect(forBounds: slider.bounds)
         let thumbRect = slider.thumbRect(forBounds: slider.bounds, trackRect: trackRect, value: slider.value)
         let thumbCenter = CGPoint(x: thumbRect.midX, y: thumbRect.midY)
         
        let x = max(
            min(thumbCenter.x,frame.width), 0
        )
        thumbnailImageView.frame.origin = CGPoint(
            x: x,
            y: thumbnailImageView.frame.origin.y
        )
     }

    weak var delegate: VideoControlDelegate?
    var isHiddenControlView: Bool = false {
        didSet {
            if isHiddenControlView {
                playerControllerStackView.fadeOut()
                playerInfoView.fadeOut()
                playerBackgroundView.fadeOut()
            } else {
                playerControllerStackView.fadeIn()
                playerInfoView.fadeIn()
                playerBackgroundView.fadeIn(displayAlpha: 0.6)
            }
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

    func setDuration(duration: Float) {
        seekBarSlider.minimumValue = 0
        seekBarSlider.maximumValue = duration
        durationTimeLabel.text = formatPlayTime(time: duration)
    }

    func switchPlayAndPauseButton(isPlaying: Bool) {
        playAndPauseButton.setImage(
            UIImage.sfsymbolImage(
                sfsymbolType: isPlaying ? .pauseFill : .playFill,
                pointSize: 56
            ),
            for: .normal
        )
    }

    func setCurrentTime(currentTime: Float) {
        currentTimeLabel.text = formatPlayTime(time: currentTime)
        seekBarSlider.value = currentTime
    }

    func setupSpeedButton(
        currentSpeed: Double,
        speeds: [Double]
    ) {
        let actions = speeds.map { speed in
            UIAction(
                title: "\(speed)x",
                state: speed == currentSpeed ? .on : .off
            ) { [weak self] action in
                self?.delegate?.didTapSpeedRate(speed: speed)
            }
        }
        videoPlaybackRateButton.menu = UIMenu(
            title: "再生スピード",
            children: actions
        )
        
        videoPlaybackRateButton.showsMenuAsPrimaryAction = true
    }

    func switchFullScreenButton(
        isFullScreen: Bool
    ) {
        fullScreenButton.setImage(
            isFullScreen
                ? UIImage.sfsymbolImage(
                    sfsymbolType: .fullScreenCancel,
                    pointSize: 24
                )
                : UIImage.sfsymbolImage(
                    sfsymbolType: .fullScreen,
                    pointSize: 24
                ),
            for: .normal
        )
    }
    
    func updateThumbnailImage(image: UIImage?) {
        thumbnailImageView.image = image
    }

    @objc
    private func skipTimeToPosision(
        gestureRecognizer: UIGestureRecognizer
    ) {
        let tapPositionX = gestureRecognizer.location(in: seekBarSlider).x
        let sliderWidth = seekBarSlider.frame.width
        let currentTime = Float(
            CGFloat(seekBarSlider.maximumValue) * (tapPositionX / sliderWidth)
        )
        delegate?.didTapSeekBar(
            currentTime: currentTime
        )
    }

    private func formatPlayTime(time: Float) -> String {
        let durationInt = Int(round(time))
        return String(
            format: "%02d:%02d",
            Int(durationInt / 60),
            Int(durationInt % 60)
        )
    }
}

import UIKit

protocol VideoControlDelegate: AnyObject {
    func didTapPlayAndPause()
    func didTapForward()
    func didTapBackward()
    func didTapFullScreen()
    func didTapSpeedRate()
    func didTapDownSeekBar(currentTime: Float)
    func didTapUpInsideOrOutsideSeekBar(currentTime: Float)
    func didTapSeekBar(currentTime: Float)
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
    
    @IBOutlet weak var videoPlaybackRateButton: UIButton! {
        didSet {
            videoPlaybackRateButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapSpeedRate()
                },
                for: .touchUpInside
            )
            videoPlaybackRateButton.layer.borderColor = UIColor.white.cgColor
            videoPlaybackRateButton.layer.cornerRadius = 3.0
            videoPlaybackRateButton.layer.borderWidth = 1.0
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

    @IBOutlet weak var seekBarSlider: UISlider! {
        didSet {
            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self,
                          let slider = action.sender as? UISlider
                    else { return }
                    self.setCurrentTime(
                        currentTime: slider.value
                    )
                },
                for: .valueChanged
            )

            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self,
                          let slider = action.sender as? UISlider
                    else { return }
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

    weak var delegate: VideoControlDelegate?
    var isHiddenControlView: Bool = false {
        didSet {
            playerControllerStackView.isHidden = isHiddenControlView
            playerInfoView.isHidden = isHiddenControlView
            playerBackgroundView.isHidden = isHiddenControlView
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

    func setPlaybackRate(
        playbackRate: VideoPlayer.PlaybackRate
    ) {
        videoPlaybackRateButton.setTitle(
            "\(playbackRate.rawValue)x",
            for: .normal
        )
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

    @objc
    private func skipTimeToPosision(
        gestureRecognizer: UIGestureRecognizer
    ) {
        let pointTapped: CGPoint = gestureRecognizer.location(
            in: seekBarSlider
        )
        let positionOfSlider: CGPoint = seekBarSlider.frame.origin
        let widthOfSlider: CGFloat = seekBarSlider.frame.size.width
        let currentTime = Float(
            (pointTapped.x - positionOfSlider.x) * CGFloat(seekBarSlider.maximumValue) / widthOfSlider
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

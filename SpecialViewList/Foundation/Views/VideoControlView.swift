import UIKit

protocol VideoControlViewDelegate: AnyObject {
    func didTapPlayAndPause()
    func didTapForward()
    func didTapBack()
    func didTapDownSeekBar(currentTime: Float)
}

class VideoControlView: UIView, NibOwnerLoadable {
    @IBOutlet weak var playAndPauseButton: UIButton! {
        didSet {
            playAndPauseButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapPlayAndPause()
                },
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var forwardButton: UIButton! {
        didSet {
            forwardButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapForward()
                },
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var backButton: UIButton!{
        didSet {
            backButton.addAction(
                UIAction { [weak self] _ in
                    self?.delegate?.didTapBack()
                },
                for: .touchUpInside
            )
        }
    }
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var seekBarSlider: UISlider! {
        didSet {
            seekBarSlider.setThumbImage(
                UIImage.sfsymbolImage(symbolType: .circleFill),
                for: .normal
            )
            
            seekBarSlider.addAction(
                UIAction { [weak self] action in
                    guard let self = self ,
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
                    guard let self = self ,
                        let slider = action.sender as? UISlider
                    else { return }
                    self.delegate?.didTapDownSeekBar(
                        currentTime: slider.value
                    )
                },
                for: .touchDown
            )
        }
    }
    
    weak var delegate: VideoControlViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setCurrentTime(currentTime: Float) {
        currentTimeLabel.text = PlayerTimeFormatter.playTime(
            time: Double(currentTime)
        )
        seekBarSlider.value = currentTime
    }
    
    func setSeekBar(totalTime: Float) {
        seekBarSlider.minimumValue = 0
        seekBarSlider.maximumValue = totalTime
    }
}


enum SFSymbolType: String {
    case xmarkCircleFill = "xmark.circle.fill"
    case xmark
    case circleFill = "circle.fill"
}

extension UIImage {
    static func sfsymbolImage(
        symbolType: SFSymbolType
    ) -> UIImage? {
        UIImage(systemName: symbolType.rawValue)
    }
    
    static func sfsymbolImage(
        symbolType: SFSymbolType,
        pointSize: CGFloat
    ) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize)
        return UIImage(
            systemName: symbolType.rawValue,
            withConfiguration: configuration
        )
    }
}

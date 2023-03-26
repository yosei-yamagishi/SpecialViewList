import UIKit

class AutoFlowedTitleView: UIView, NibOwnerLoadable {
    enum ViewStatus {
        case noNeedMove // 動く必要なし
        case stopOnLeft // 左止まり
        case flowingFromLeft // 左から動いてる
        case stopOnRight // 右止まり
        case flowingFormRight // 右から動いている
        
        // タイトルを流す方向
        var scrollDirectionValue: Double {
            switch self {
            case .flowingFromLeft: return 1.0
            case .flowingFormRight: return -1.0
            default: return 0
            }
        }
    }
    
    @IBOutlet var autoScrollView: UIScrollView!
    @IBOutlet var animationTitleLabel: UILabel!
    
    @IBOutlet var leftGradationView: UIView! {
        didSet {
            leftGradationView.layer.addSublayer(
                gradationLayer(colors: config.leftGradationColors)
            )
        }
    }

    @IBOutlet var rightGradationView: UIView! {
        didSet {
            rightGradationView.layer.addSublayer(
                gradationLayer(colors: config.rightGradationColors)
            )
        }
    }
    

    private let config = AutoFlowedTitleConfig()
    private var viewStatus: ViewStatus = .noNeedMove {
        didSet {
            updateView(viewStatus: viewStatus)
        }
    }
    private var moveOffset: CGFloat = 0 // 現在のスクロール位置
    private var scrollTimer: Timer? // スクロールさせるタイマー
    private var scrollWaitingTimer: Timer? // スクロールさせるまで待つためのタイマー

    // タイトルラベルの横幅がスクロールViewの横幅を超えているかどうか
    private var isOverTextWidth: Bool {
        autoScrollView.frame.width <= animationTitleLabel.frame.width
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    func initTitle(title: String) {
        stopScrollTimer()
        stopWatingTimer()
        animationTitleLabel.text = title
        animationTitleLabel.sizeToFit()
        viewStatus = isOverTextWidth ? .stopOnLeft : .noNeedMove
    }
    
    private func updateView(viewStatus: ViewStatus) {
        switch viewStatus {
        case .noNeedMove:
            leftGradationView.isHidden = true
            rightGradationView.isHidden = true
        case .stopOnLeft:
            moveOffset = 0
            setScrollOffset(value: 0)
            startWatingTimer()
            leftGradationView.isHidden = true
            rightGradationView.isHidden = false
        case .flowingFromLeft:
            startScrollTimer()
            leftGradationView.isHidden = false
            rightGradationView.isHidden = false
        case .stopOnRight:
            startWatingTimer()
            leftGradationView.isHidden = false
            rightGradationView.isHidden = true
        case .flowingFormRight:
            startScrollTimer()
            leftGradationView.isHidden = false
            rightGradationView.isHidden = false
        }
    }
}

// MARK: Viewの操作

extension AutoFlowedTitleView {
    private func setScrollOffset(value: CGFloat) {
        autoScrollView.setContentOffset(
            CGPoint(x: value, y: 0),
            animated: false
        )
    }

    private func gradationLayer(colors: [CGColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(
            origin: .zero,
            size: config.gradationSize
        )
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }
}

// MARK: タイマー操作

extension AutoFlowedTitleView {
    // スクロールするまで待つためのタイマーをスタート
    private func startWatingTimer() {
        let timer = Timer.scheduledTimer(
            withTimeInterval: config.scrollWaitingTimeTinterval,
            repeats: false
        ) { [weak self] _ in
            guard let self = self else { return }
            switch self.viewStatus {
            case .stopOnLeft:
                self.viewStatus = .flowingFromLeft
            case .stopOnRight:
                self.viewStatus = .flowingFormRight
            default: break
            }
            self.stopWatingTimer()
        }
        scrollWaitingTimer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    private func stopWatingTimer() {
        scrollWaitingTimer?.invalidate()
        scrollWaitingTimer = nil
    }

    private func startScrollTimer() {
        let timer = Timer.scheduledTimer(
            withTimeInterval: config.scrollTimerTimeInterval,
            repeats: true
        ) { [weak self] _ in
            guard let self = self else { return }
            self.moveOffset += self.config.moveDuration * self.viewStatus.scrollDirectionValue
            self.setScrollOffset(value: self.moveOffset)
            
            switch self.viewStatus {
            case .flowingFromLeft:
                let enableScrollOffset = self.animationTitleLabel.frame.width - self.autoScrollView.frame.width
                if enableScrollOffset <= self.moveOffset {
                    self.viewStatus = .stopOnRight
                    self.stopScrollTimer()
                }
            case .flowingFormRight:
                if self.moveOffset <= 0 {
                    self.viewStatus = .stopOnLeft
                    self.stopScrollTimer()
                }
            default:
                return
            }
        }
        scrollTimer = timer
        RunLoop.current.add(timer, forMode: .common)
    }

    private func stopScrollTimer() {
        scrollTimer?.invalidate()
        scrollTimer = nil
    }
}

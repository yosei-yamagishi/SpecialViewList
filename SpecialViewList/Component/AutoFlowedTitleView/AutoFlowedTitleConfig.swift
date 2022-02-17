import UIKit

struct AutoFlowedTitleConfig {
    let moveDuration: CGFloat = 1.0 // スクロールの動く範囲
    let scrollTimerTimeInterval: CGFloat = 0.05
    let scrollWaitingTimeTinterval: CGFloat = 3.0
    let gradationSize = CGSize(width: 16, height: 44)
    let gradationViewColor: UIColor = .lightText
    
    var leftGradationColors: [CGColor] {
        [
            gradationViewColor.withAlphaComponent(0.8).cgColor,
            gradationViewColor.withAlphaComponent(0.1).cgColor
        ]
    }
    var rightGradationColors: [CGColor] {
        [
            gradationViewColor.withAlphaComponent(0.1).cgColor,
            gradationViewColor.withAlphaComponent(0.8).cgColor
        ]
    }
}

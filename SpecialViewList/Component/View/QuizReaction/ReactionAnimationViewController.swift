import UIKit

class ReactionAnimationViewController: UIViewController {

    @IBOutlet weak var animationViewBottomConstraint: NSLayoutConstraint! {
        didSet {
            animationViewBottomConstraint.constant = 200
        }
    }
    @IBOutlet weak var animateButton: UIButton! {
        didSet {
            animateButton.addAction(
                UIAction { [weak self] _ in
                    self?.animateView()
                },
                for: .touchUpInside
            )
        }
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func animateView() {
        animationViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}

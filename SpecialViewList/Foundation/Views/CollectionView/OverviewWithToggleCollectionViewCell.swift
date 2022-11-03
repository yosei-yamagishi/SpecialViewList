import UIKit

protocol OverviewWithToggleCollectionViewCellDelegate: AnyObject {
    func didTapToggleOverview()
}

class OverviewWithToggleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var overviewTextView: UITextView! {
        didSet {
            overviewTextView.dataDetectorTypes = UIDataDetectorTypes.link
            overviewTextView.linkTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.blue
            ]

            overviewTextView.isMultipleTouchEnabled = true
            overviewTextView.isSelectable = true
            overviewTextView.isEditable = false
            overviewTextView.isScrollEnabled = false
            overviewTextView.textContainer.maximumNumberOfLines = 2
            overviewTextView.textContainer.lineBreakMode = .byTruncatingTail
            overviewTextView.textContainerInset = .zero
            overviewTextView.textContainer.lineFragmentPadding = .zero
        }
    }
    @IBOutlet weak var dummyLabel: UILabel! {
        didSet {
            dummyLabel.numberOfLines = 2
        }
    }
    
    @IBOutlet weak var toggleOverviewButton: UIButton! {
        didSet {
            toggleOverviewButton.addAction(
                UIAction { [weak self] _ in
                    self?.toggleOverview()
                    self?.delegate?.didTapToggleOverview()
                },
                for: .touchUpInside
            )
        }
    }
    
    weak var delegate: OverviewWithToggleCollectionViewCellDelegate?
    
    func setOverview(overview: String) {
        overviewTextView.text = overview
        dummyLabel.text = overview
    }
    
    
    private func toggleOverview() {
        switch overviewTextView.textContainer.maximumNumberOfLines {
        case 0:
            overviewTextView.textContainer.maximumNumberOfLines = 2
            toggleOverviewButton.setTitle(
                "もっと見る",
                for: .normal
            )
            overviewTextView.textContainer.lineBreakMode = .byTruncatingTail
            dummyLabel.numberOfLines = 2
        case 2:
            overviewTextView.textContainer.maximumNumberOfLines = 0
            toggleOverviewButton.setTitle(
                "閉じる",
                for: .normal
            )
            overviewTextView.textContainer.lineBreakMode = .byClipping
            dummyLabel.numberOfLines = 0
        default:
            return
        }
    }
}

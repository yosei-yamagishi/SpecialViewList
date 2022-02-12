import UIKit

protocol Grid3x3ViewDelegate: AnyObject {
    func didTapContent(content: ItemContent)
}

class Grid3x3View: UIView, NibOwnerLoadable {
    static let oneLineHeight: CGFloat = 44
    
    enum LineType {
        case first, second, third
        
        var range: Range<Int> {
            switch self {
            case .first: return 0 ..< 3
            case .second: return 3 ..< 6
            case .third: return 6 ..< 9
            }
        }
    }
    @IBOutlet var firstLineStackView: UIStackView! {
        didSet { firstLineStackView.isHidden = true }
    }

    @IBOutlet var secondLineStackView: UIStackView! {
        didSet { secondLineStackView.isHidden = true }
    }

    @IBOutlet var thirdLineStackView: UIStackView! {
        didSet { thirdLineStackView.isHidden = true }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    weak var delegate: Grid3x3ViewDelegate?

    func setup(
        contents: [ItemContent]
    ) {
        removeLineView()
        setupView(contents: contents)
        showLineStackView(contentsCount: contents.count)
    }

    private func removeLineView() {
        firstLineStackView.arrangedSubviews.forEach {
            firstLineStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        secondLineStackView.arrangedSubviews.forEach {
            secondLineStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        thirdLineStackView.arrangedSubviews.forEach {
            thirdLineStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }

    private func setupView(contents: [ItemContent]) {
        for (index, content) in contents.enumerated() {
            if LineType.first.range.contains(index) {
                firstLineStackView.addArrangedSubview(
                    createLiveTopicView(content: content)
                )
            } else if LineType.second.range.contains(index) {
                secondLineStackView.addArrangedSubview(
                    createLiveTopicView(content: content)
                )
            } else if LineType.third.range.contains(index) {
                thirdLineStackView.addArrangedSubview(
                    createLiveTopicView(content: content)
                )
            }
        }
    }

    private func createLiveTopicView(content: ItemContent) -> Grid3x3ItemView {
        let itemView = Grid3x3ItemView()
        itemView.setup(content: content)
        itemView.isUserInteractionEnabled = true
        let tapGesture = Grid3x3ItemTapGesture(
            target: self,
            action: #selector(selectContent)
        )
        tapGesture.content = content
        itemView.addGestureRecognizer(tapGesture)
        return itemView
    }

    @objc
    private func selectContent(_ sender: Grid3x3ItemTapGesture) {
        guard let content = sender.content else { return }
        delegate?.didTapContent(content: content)
    }

    private func showLineStackView(contentsCount: Int) {
        let isShowOneLine = contentsCount <= LineType.first.range.count
        let isShowTwoLine = LineType.first.range.count < contentsCount
            && contentsCount <= LineType.first.range.count + LineType.second.range.count

        if isShowOneLine {
            firstLineStackView.isHidden = false
            secondLineStackView.isHidden = true
            thirdLineStackView.isHidden = true
        } else if isShowTwoLine {
            firstLineStackView.isHidden = false
            secondLineStackView.isHidden = false
            thirdLineStackView.isHidden = true
        } else {
            firstLineStackView.isHidden = false
            secondLineStackView.isHidden = false
            thirdLineStackView.isHidden = false
        }
    }
}

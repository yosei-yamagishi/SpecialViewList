import UIKit

protocol LinkLabelViewDelegate: AnyObject {
    func didTapLink(url: URL)
}

class LinkLabelView: UIView, NibOwnerLoadable {
    @IBOutlet var baseView: UIView! {
        didSet {
            baseView.defaultMaskCorner()
        }
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var discriptionLabel: UILabel!
    
    @IBOutlet var link1Label: UILabel! {
        didSet {
            link1Label.isUserInteractionEnabled = true
            let linkText = "気を付けるべきポイント①"
            let linkUrlString =
                "https://note.com/"
            link1Label.attributedText = underLineAttributedString(text: linkText)
            let tapGesture = LabelLinkTapGesture(
                target: self,
                action: #selector(selectLink)
            )
            tapGesture.ulrString = linkUrlString
            link1Label.addGestureRecognizer(tapGesture)
        }
    }

    @IBOutlet var link2Label: UILabel! {
        didSet {
            link2Label.isUserInteractionEnabled = true
            let linkText = "気を付けるべきポイント②"
            let linkUrlString =
                "https://www.lineblog.me/"
            link2Label.attributedText = underLineAttributedString(text: linkText)
            let tapGesture = LabelLinkTapGesture(
                target: self,
                action: #selector(selectLink)
            )
            tapGesture.ulrString = linkUrlString
            link2Label.addGestureRecognizer(tapGesture)
        }
    }
    
    weak var delegate: LinkLabelViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    @objc
    private func selectLink(
        gesture: LabelLinkTapGesture
    ) {
        guard let urlString = gesture.ulrString,
              let url = URL(string: urlString)
        else { return }
        delegate?.didTapLink(url: url)
    }
    
    private func underLineAttributedString(text: String) -> NSAttributedString {
        let textColor: UIColor = .systemIndigo
        let underLineColor: UIColor = .systemIndigo
        let underLineStyle = NSUnderlineStyle.single.rawValue
        let labelAtributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.underlineStyle: underLineStyle,
            NSAttributedString.Key.underlineColor: underLineColor
        ]
        return NSAttributedString(
            string: text,
            attributes: labelAtributes
        )
    }
}

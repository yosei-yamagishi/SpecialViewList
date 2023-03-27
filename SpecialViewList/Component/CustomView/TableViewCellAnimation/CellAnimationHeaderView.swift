import UIKit

protocol CellAnimationHeaderViewDelegate: AnyObject {
    func didTapHeader(section: Int)
}

class CellAnimationHeaderView: UIView, NibOwnerLoadable {
    static var headerSize: CGSize {
        CGSize(
            width: UIScreen.main.bounds.width,
            height: 52
        )
    }
        
    @IBOutlet weak var headerBaseView: UIView! {
        didSet {
            headerBaseView.border(borderCGColor: UIColor.gray.cgColor)
        }
    }
    
    @IBOutlet weak var headerTitileLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView! {
        didSet {
            arrowImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
    }
    @IBOutlet weak var openButton: UIButton! {
        didSet {
            let action = UIAction(handler: { [weak self] _ in
                guard let self = self, let section = self.section else { return }
                self.delegate?.didTapHeader(section: section)
            })
            openButton.addAction(
                action,
                for: .touchUpInside
            )
        }
    }
    
    private var section: Int?
    weak var delegate: CellAnimationHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setHeaderTitle(
        title: String,
        section: Int,
        isHiddenContents: Bool
    ) {
        self.section = section
        headerTitileLabel.text = title
        arrowImageView.image = UIImage(
            systemName: isHiddenContents
                ? "arrowtriangle.down.fill"
                : "arrowtriangle.up.fill"
        )
    }
}

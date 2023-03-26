import UIKit

class Grid3x3ItemView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var baseView: UIView! {
        didSet {
            baseView.defaultMaskCorner()
        }
    }
    @IBOutlet weak var itemLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }

    func setup(content: ItemContent) {
        itemLabel.text = content.name
    }
}

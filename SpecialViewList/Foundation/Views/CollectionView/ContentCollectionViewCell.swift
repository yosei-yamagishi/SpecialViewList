import UIKit

class ContentCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var baseViewWidth: NSLayoutConstraint! {
        didSet {
            baseViewWidth.constant = UIScreen.main.bounds.width
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(titleText: String) {
        titleLabel.text = titleText
    }
}

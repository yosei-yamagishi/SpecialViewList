import UIKit

class CellAnimationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func set(title: String) {
        titleLabel.text = title
    }
}

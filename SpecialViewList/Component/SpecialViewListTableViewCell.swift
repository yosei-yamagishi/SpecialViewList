import UIKit

class SpecialViewListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    
    func setup(title: String, discription: String) {
        accessoryType = .disclosureIndicator
        titleLabel.text = title
        discriptionLabel.text = discription
    }
}

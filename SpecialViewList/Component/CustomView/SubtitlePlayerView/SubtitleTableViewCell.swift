import UIKit

class SubtitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func setup(subtitle: String) {
        subtitleLabel.text = subtitle
        selectionStyle = .none
    }
    
    func activateText(isActivated: Bool) {
        subtitleLabel.alpha = isActivated ? 1 : 0.5
    }
}

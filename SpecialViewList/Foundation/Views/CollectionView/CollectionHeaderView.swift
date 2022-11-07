import UIKit

final class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    func setHeaderTitle(headerTitle: String) {
        headerLabel.text = headerTitle
    }
}

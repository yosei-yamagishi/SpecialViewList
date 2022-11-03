import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func setImage(fileName: String) {
        imageView.image = UIImage(named: fileName)
    }
}

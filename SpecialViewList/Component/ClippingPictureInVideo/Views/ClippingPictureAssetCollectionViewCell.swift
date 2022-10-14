import UIKit

class ClippingPictureAssetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func set(image: UIImage, time: Float) {
        pictureImageView.image = image
        timeLabel.text = time.description
    }
}

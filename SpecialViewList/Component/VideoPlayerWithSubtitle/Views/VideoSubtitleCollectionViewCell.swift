import UIKit

class VideoSubtitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel! {
        didSet {
            currentTimeLabel.maskCorner(radius: 6)
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setup(
        thumbnailImageName: String,
        subtitle: String,
        currentTime: String
    ) {
        thumbnailImageView.image = UIImage(
            named: thumbnailImageName
        )
        subtitleLabel.text = subtitle
        currentTimeLabel.text = currentTime
    }
    
    func activateText(isActivated: Bool) {
        subtitleLabel.font = UIFont.systemFont(
            ofSize: 15,
            weight: isActivated ? .regular : .bold
        )
        subtitleLabel.alpha = isActivated ? 1 : 0.5
    }
}

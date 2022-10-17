import UIKit

protocol TextFieldCollectionViewCellDelegate: AnyObject {
    func didBeginEditing(indexPath: IndexPath)
    func didTapReturn()
}

class TextFieldCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textFieldView: UITextField! {
        didSet {
            textFieldView.delegate = self
        }
    }
    
    weak var delegate: TextFieldCollectionViewCellDelegate?
    private var indexPath: IndexPath?
    
    func setIndexPath(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
}

extension TextFieldCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let indexPath = indexPath else { return }
        delegate?.didBeginEditing(indexPath: indexPath)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.didTapReturn()
        return true
    }
}

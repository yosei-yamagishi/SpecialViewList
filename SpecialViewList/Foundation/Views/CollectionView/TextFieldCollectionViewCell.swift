import UIKit

class TextFieldCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textFieldView: UITextField! {
        didSet {
            textFieldView.delegate = self
        }
    }
}

extension TextFieldCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

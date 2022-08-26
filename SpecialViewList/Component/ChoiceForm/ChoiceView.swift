import UIKit

protocol ChoiceViewDelegate: AnyObject {
    func didTapRemoveChoice(position: Int)
    func didBeginEditing()
    func editingText(position: Int, text: String)
}

class ChoiceView: UIView, NibOwnerLoadable {
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.addAction(
                UIAction(handler: { [weak self] _ in
                    guard let self = self,
                          let position = self.position else { return }
                    self.delegate?.didTapRemoveChoice(
                        position: position
                    )
                }),
                for: .touchUpInside
            )
            deleteButton.setImage(
                UIImage(systemName: "minus.circle.fill"),
                for: .normal
            )
            deleteButton.allMaskCorner()
        }
    }
    
    @IBOutlet var textFieldBaseView: UIView! {
        didSet { textFieldBaseView.defaultMaskCorner() }
    }

    @IBOutlet var textField: UITextField! {
        didSet {
            textField.defaultMaskCorner()
            textField.delegate = self
            textField.addAction(
                UIAction(handler: { [weak self] action in
                    guard let self = self,
                          let position = self.position,
                          let textField = action.sender as? UITextField,
                          let text = textField.text
                    else { return }
                        self.textCountLabel.text = self.leftTextCountMessage(
                            text: text,
                            maxCount: self.choiceTextMaxCount
                        )
                    self.delegate?.editingText(
                        position: position,
                        text: text
                    )
                }),
                for: .editingChanged
            )
        }
    }
    @IBOutlet var textCountLabel: UILabel!
    @IBOutlet var errorMessageLabel: UILabel! {
        didSet {
            errorMessageLabel.isHidden = true
        }
    }
    
    private var position: Int?
    private var choiceTextMaxCount: Int = 0
    
    weak var delegate: ChoiceViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setupChoice(
        position: Int,
        choiceTextMaxCount: Int,
        placeholderText: String,
        isHiddenDeleteButton: Bool
    ) {
        self.position = position
        self.textField.placeholder = placeholderText
        self.choiceTextMaxCount = choiceTextMaxCount
        deleteButton.isHidden = isHiddenDeleteButton
    }
    
    func updateChoice(choice: String) {
        textField.text = choice
        textCountLabel.text = self.leftTextCountMessage(
            text: choice,
            maxCount: choiceTextMaxCount
        )
    }
    
    private func leftTextCountMessage(
        text: String,
        maxCount: Int
    ) -> String {
        let leftCount = maxCount - text.count
        return leftCount < 0
            ? "\(-leftCount)文字数オーバー"
            : "\(text.count)/\(maxCount)"
    }
}

extension ChoiceView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing()
    }
}

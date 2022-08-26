import UIKit

protocol ChoiceFormViewDelegate: AnyObject {
    func editingChoice(position: Int, text: String)
    func didTapAddChoice()
    func didTapRemoveChoice(position: Int)
    func didBeginEditing()
}

class ChoiceFormView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var addChoiceButton: UIButton! {
        didSet {
            addChoiceButton.boarderWithMaskCorner(
                borderCGColor: UIColor.blue.cgColor
            )
            addChoiceButton.addAction(
                UIAction(handler: { [weak self] _ in
                    guard let self = self else { return }
                    self.delegate?.didTapAddChoice()
                }),
                for: .touchUpInside
            )
        }
    }
    
    @IBOutlet weak var choice1View: ChoiceView! {
        didSet {
            choice1View.delegate = self
            choice1View.setupChoice(
                position: 1,
                choiceTextMaxCount: maxChoiceTextCount,
                placeholderText: "選択肢1",
                isHiddenDeleteButton: true
            )
        }
    }
    @IBOutlet weak var choice2View: ChoiceView! {
        didSet {
            choice2View.delegate = self
            choice2View.setupChoice(
                position: 2,
                choiceTextMaxCount: maxChoiceTextCount,
                placeholderText: "選択肢2",
                isHiddenDeleteButton: false
            )
        }
    }
    @IBOutlet weak var choice3View: ChoiceView! {
        didSet {
            choice3View.delegate = self
            choice3View.setupChoice(
                position: 3,
                choiceTextMaxCount: maxChoiceTextCount,
                placeholderText: "選択肢3",
                isHiddenDeleteButton: false
            )
        }
    }
    @IBOutlet weak var choice4View: ChoiceView! {
        didSet {
            choice4View.delegate = self
            choice4View.setupChoice(
                position: 4,
                choiceTextMaxCount: maxChoiceTextCount,
                placeholderText: "選択肢4",
                isHiddenDeleteButton: false
            )
        }
    }
    
    weak var delegate: ChoiceFormViewDelegate?
    private var choices: [String] = [""]
    private var maxChoiceTextCount: Int = 20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func set(maxChoiceTextCount: Int) {
        self.maxChoiceTextCount = maxChoiceTextCount
    }
    
    func updateChoices(choices: [String]) {
        self.choices = choices
        switch choices.count {
        case 1:
            choice1View.isHidden = false
            choice1View.updateChoice(choice: choices[0])
            choice2View.isHidden = true
            choice2View.updateChoice(choice: "")
            choice3View.isHidden = true
            choice3View.updateChoice(choice: "")
            choice4View.isHidden = true
            choice4View.updateChoice(choice: "")
            addChoiceButton.isHidden = false
        case 2:
            choice1View.isHidden = false
            choice1View.updateChoice(choice: choices[0])
            choice2View.isHidden = false
            choice2View.updateChoice(choice: choices[1])
            choice3View.isHidden = true
            choice3View.updateChoice(choice: "")
            choice4View.isHidden = true
            choice4View.updateChoice(choice: "")
            addChoiceButton.isHidden = false
        case 3:
            choice1View.isHidden = false
            choice1View.updateChoice(choice: choices[0])
            choice2View.isHidden = false
            choice2View.updateChoice(choice: choices[1])
            choice3View.isHidden = false
            choice3View.updateChoice(choice: choices[2])
            choice4View.isHidden = true
            choice4View.updateChoice(choice: "")
            addChoiceButton.isHidden = false
        case 4:
            choice1View.isHidden = false
            choice1View.updateChoice(choice: choices[0])
            choice2View.isHidden = false
            choice2View.updateChoice(choice: choices[1])
            choice3View.isHidden = false
            choice3View.updateChoice(choice: choices[2])
            choice4View.isHidden = false
            choice4View.updateChoice(choice: choices[3])
            addChoiceButton.isHidden = true
        default:
            break
        }
        
        
    }
}

extension ChoiceFormView: ChoiceViewDelegate {
    func didTapRemoveChoice(position: Int) {
        delegate?.didTapRemoveChoice(position: position)
    }
    
    func didBeginEditing() {
        delegate?.didBeginEditing()
    }
    
    func editingText(position: Int, text: String) {
        delegate?.editingChoice(
            position: position,
            text: text
        )
    }
}

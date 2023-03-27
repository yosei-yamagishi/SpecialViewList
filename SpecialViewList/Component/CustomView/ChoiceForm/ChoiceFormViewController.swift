import UIKit
import Combine

class ChoiceFormViewController: UIViewController {
    @IBOutlet weak var choiceFormView: ChoiceFormView! {
        didSet {
            choiceFormView.delegate = self
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: ChoiceFormViewModel
    
    init(viewModel: ChoiceFormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.$choices.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] choices in
                self?.choiceFormView.updateChoices(choices: choices)
            })
            .store(in: &cancellables)
    }
}

extension ChoiceFormViewController: ChoiceFormViewDelegate {
    func editingChoice(position: Int, text: String) {
        viewModel.updateChoice(
            position: position,
            choice: text
        )
    }
    
    func didTapAddChoice() {
        viewModel.addChoice()
    }
    
    func didTapRemoveChoice(position: Int) {
        viewModel.removeChoice(position: position)
    }
    
    func didBeginEditing() {
        
    }
}

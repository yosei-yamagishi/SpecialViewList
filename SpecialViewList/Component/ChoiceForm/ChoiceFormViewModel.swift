import Combine

class ChoiceFormViewModel {
    @Published var choices: [String] = [""]
    
    func updateChoice(position: Int, choice: String) {
        let index = position - 1
        choices[index] = choice
    }
    
    func addChoice() {
        choices.append("")
    }
    
    func removeChoice(position: Int) {
        if choices.count > 1 {
            let index = position - 1
            choices.remove(at: index)
        }
    }
}

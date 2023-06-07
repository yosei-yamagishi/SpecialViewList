import UIKit
import Combine

class DummyViewModel: ObservableObject, UDFViewModel {
    enum Action {
        case viewDidLoad
    }
    
    struct State: Equatable {
        var itemName: String = ""
    }
    
    @Published var state: State
    private let item: ItemContent
    
    init(
        item: ItemContent,
        state: State = State()
    ) {
        self.item = item
        self.state = state
        self.state.itemName = item.name
    }
    
    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            fetchContents()
        }
    }
    
    private func fetchContents() {
        print("fetch")
    }
}

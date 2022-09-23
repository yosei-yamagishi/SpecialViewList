import Combine

class NextHostingControllerViewModel: ObservableObject, UDFViewModel {
    enum Action {
        case dismissView
    }
    
    enum NextHostingBaseTransitionScreen {
        case dismissView
    }
    
    struct State: Equatable {
        var transitionScreen: NextHostingBaseTransitionScreen?
    }
    
    @Published var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {
        switch action {
        case .dismissView:
            state.transitionScreen = .dismissView
        }
    }
}

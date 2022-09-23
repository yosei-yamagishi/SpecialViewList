import Combine

class HostingControllerViewModel: ObservableObject, UDFViewModel {
    enum Action {
        case didTapClearText
        case didTapOpenNextHostingBaseView
    }
    
    enum HostingBaseTransitionScreen {
        case nextHostingBaseView
    }
    
    struct State: Equatable {
        var name: String = ""
        var transitionScreen: HostingBaseTransitionScreen?
    }
    
    @Published var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {
        switch action {
        case .didTapClearText:
            state.name = ""
        case .didTapOpenNextHostingBaseView:
            state.transitionScreen = .nextHostingBaseView
        }
    }
}

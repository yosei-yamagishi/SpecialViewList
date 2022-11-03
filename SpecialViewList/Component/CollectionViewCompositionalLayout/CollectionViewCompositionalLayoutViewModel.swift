import Combine

class CollectionViewCompositionalLayoutViewModel: UDFViewModel {
    enum Action {
        case viewDidLoad
    }
    
    struct State: Equatable {
        let sections: [SectionType] = SectionType.allCases
        var contentDetail: CollectionContentDetail = .sample
    }
    enum SectionType: CaseIterable {
        case thumbnail
        case titleText
        case overview
        case content
    }
    
    @Published private(set) var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            fetchContentDetail()
        }
    }
    
    private func fetchContentDetail() {
        state.contentDetail = .sample
    }
}

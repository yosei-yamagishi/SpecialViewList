import UIKit
import Combine

class MypageOfSwiftUIViewModel: ObservableObject, UDFViewModel {
    enum Action {
        case onAppearMainView
        case didTapProfile
        case didTapSave
        case didTapDownload
        case didTapItem(index: Int)
    }
    
    struct State: Equatable {
        enum ScreenTransition {
            case profile
            case itemDetail(item: ItemContent)
        }
        var items: [ItemContent] = []
        var screenTransition: ValueEventTrigger<ScreenTransition>?
    }
    
    @Published var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppearMainView:
            fetchContents()
        case .didTapProfile:
            state.screenTransition = .init(
                value: .profile
            )
        case .didTapSave:
            break
        case .didTapDownload:
            break
        case .didTapItem(index: let index):
            state.screenTransition = .init(
                value: .itemDetail(item: state.items[index])
            )
        }
    }
    
    private func fetchContents() {
        state.items = ItemContent.listContents
    }
}

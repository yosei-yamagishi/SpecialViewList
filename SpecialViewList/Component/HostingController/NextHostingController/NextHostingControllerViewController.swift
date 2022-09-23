import UIKit
import SwiftUI
import Combine

class NextHostingControllerViewController: UIHostingController<NextHostingBaseView> {
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(viewModel: NextHostingControllerViewModel) {
        super.init(
            rootView: NextHostingBaseView(
                viewModel: viewModel
            )
        )
        
        viewModel.$state.map(\.transitionScreen)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue:  { [weak self] transitionScreen in
                switch transitionScreen {
                case .dismissView:
                    self?.dismiss(animated: true)
                }
            })
            .store(in: &cancellables)
    }
    
    
    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

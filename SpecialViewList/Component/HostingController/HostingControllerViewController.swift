import UIKit
import SwiftUI
import Combine

class HostingControllerViewController: UIHostingController<HostingBaseView> {

    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HostingControllerViewModel) {
        super.init(
            rootView: HostingBaseView(
                viewModel: viewModel
            )
        )
        
        viewModel.$state.map(\.transitionScreen)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue:  { [weak self] transitionScreen in
                switch transitionScreen {
                case .nextHostingBaseView:
                    let controller = NextHostingControllerViewController(
                        viewModel: NextHostingControllerViewModel()
                    )
                    let navigationController = UINavigationController()
                    navigationController.viewControllers = [controller]
                    self?.present(navigationController, animated: true)
                }
            })
            .store(in: &cancellables)
    }
    
    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

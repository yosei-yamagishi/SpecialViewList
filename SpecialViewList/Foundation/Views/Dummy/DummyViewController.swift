import UIKit
import SwiftUI

struct DummyView: View {
    @ObservedObject private var viewModel: DummyViewModel
    
    init(viewModel: DummyViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Text("Dummy")
        Text("itemName:" + viewModel.state.itemName)
    }
}

class DummyViewController: UIHostingController<DummyView> {
    
    init(viewModel: DummyViewModel) {
        super.init(
            rootView: DummyView(viewModel: viewModel)
        )
    }
    
    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "ダミー画面"
    }
}

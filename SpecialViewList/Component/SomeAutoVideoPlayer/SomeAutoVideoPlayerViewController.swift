import UIKit

class SomeAutoVideoPlayerViewController: UIViewController {
    
    private let viewModel: SomeAutoVideoPlayerViewModel
    
    init(viewModel: SomeAutoVideoPlayerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

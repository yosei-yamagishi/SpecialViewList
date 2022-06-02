import UIKit

class VideoCollectionViewController: UIViewController {
    
    private let viewModel: VideoCollectionViewModel

    init(viewModel: VideoCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import UIKit

class AutoFlowedTitleViewController: UIViewController {

    @IBOutlet weak var autoFlowedTitleView: AutoFlowedTitleView!
    private let viewModel: AutoFlowedTitleViewModel
    
    init(viewModel: AutoFlowedTitleViewModel = AutoFlowedTitleViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.specialViewListItem.title
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        autoFlowedTitleView.initTitle(title: viewModel.title)
    }
}

import UIKit
import SafariServices

class LinkLabelViewController: UIViewController {
    
    @IBOutlet weak var linkLabelView: LinkLabelView! {
        didSet {
            linkLabelView.delegate = self
        }
    }
    
    private let viewModel: LinkLabelViewModel
    
    init(
        viewModel: LinkLabelViewModel = LinkLabelViewModel()
    ) {
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
}

extension LinkLabelViewController: LinkLabelViewDelegate {
    func didTapLink(url: URL) {
        let controller = SFSafariViewController(url: url)
        controller.dismissButtonStyle = .close
        present(controller, animated: true)
    }
}

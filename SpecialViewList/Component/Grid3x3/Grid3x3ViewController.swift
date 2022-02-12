import UIKit

class Grid3x3ViewController: UIViewController {

    @IBOutlet weak var gridView: Grid3x3View! {
        didSet {
            gridView.delegate = self
        }
    }
    private let viewModel: Grid3x3ViewModel
    
    init(viewModel: Grid3x3ViewModel = Grid3x3ViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.setup(contents: viewModel.contents)
        navigationItem.title = viewModel.specialViewList.title
    }
}

extension Grid3x3ViewController: Grid3x3ViewDelegate {
    func didTapContent(content: ItemContent) {
        print(content)
    }
}

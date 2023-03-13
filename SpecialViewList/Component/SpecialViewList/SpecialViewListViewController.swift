import UIKit

class SpecialViewListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerNib(
                cellType: SpecialViewListTableViewCell.self
            )
        }
    }
    
    private let viewModel: SpecialViewListViewModel
    
    init(
        viewModel: SpecialViewListViewModel = SpecialViewListViewModel()
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
        navigationItem.title = "サンプル一覧"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func openView(listItem: SpecialViewList.Item) {
        switch listItem {
        case .grid3x3:
            let controller = Grid3x3ViewController()
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .autoFlowedTitle:
            let controller = AutoFlowedTitleViewController()
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .linkLabel:
            let controller = LinkLabelViewController()
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .subtitlePlayer:
            let controller = SubtitlePlayerViewController()
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .videoCollection:
            let videoPlayer = VideoPlayer()
            let viewModel = VideoCollectionViewModel(videoPlayer: videoPlayer)
            let controller = VideoCollectionViewController(
                videoPlayer: videoPlayer,
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .choiceForm:
            let viewModel = ChoiceFormViewModel()
            let controller = ChoiceFormViewController(
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .tableViewCellAnimation:
            let viewModel = TableViewCellAnimationViewModel()
            let controller = TableViewCellAnimationViewController(
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .defaultAVPlayerView:
            let videoPlayer = VideoPlayer()
            let viewModel = DefaultAVPlayerViewModel(
                videoPlayer: videoPlayer
            )
            let controller =  DefaultAVPlayerViewController(
                videoPlayer: videoPlayer,
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .orientation:
            let controller = RotateScreenSampleViewController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
        case .hostingController:
            let viewModel = HostingControllerViewModel()
            let controller = HostingControllerViewController(
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .loginByConcurrency:
            let viewModel = LoginViewModel<AuthServiceImp>()
            let controller = LoginByConcurrencyViewController(
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .videoPreviewOnCollectionView:
            let videoPlayer = VideoPlayer()
            let viewModel = VideoOnCollectionViewModel(
                videoPlayer: videoPlayer
            )
            let controller = VideoOnCollectionViewController(
                viewModel: viewModel,
                videoPlayer: videoPlayer
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .bottomUpKeyboardHeightView:
            let viewModel = BottomUpKeyboardHeightViewModel()
            let controller = BottomUpKeyboardHeightViewController(
                viewModel: viewModel
            )
            navigationController?.pushViewController(
                controller,
                animated: true
            )
        case .collectionViewCompositionalLayoutView:
            let viewModel = CollectionViewCompositionalLayoutViewModel()
            let controller = CollectionViewCompositionalLayoutViewController(
                viewModel: viewModel
            )
            let nav = UINavigationController()
            nav.viewControllers = [controller]
            present(nav, animated: true)
        case .videoPlayerWithSubtitle:
            let videoPlayer = VideoPlayer()
            let viewModel = VideoPlayerWithSubtitleViewModel(
                videoPlayer: videoPlayer
            )
            let controller = VideoPlayerWithSubtitleViewController(
                viewModel: viewModel,
                videoPlayer: videoPlayer
            )
            let nav = UINavigationController()
            nav.viewControllers = [controller]
            present(nav, animated: true)
        }
    }
}

extension SpecialViewListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.listSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listSections[section].items.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let listSection = viewModel.listSections[indexPath.section]
        let item = listSection.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath) as SpecialViewListTableViewCell
        cell.setup(
            title: item.title,
            discription: item.discription
        )
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        viewModel.listSections[section].title
    }
}

extension SpecialViewListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
        
        let listSection = viewModel.listSections[indexPath.section]
        openView(
            listItem: listSection.items[indexPath.row]
        )
    }
}

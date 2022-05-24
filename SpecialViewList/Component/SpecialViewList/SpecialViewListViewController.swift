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
        switch listSection {
        case .customView:
            let item = listSection.items[indexPath.row]
            let cell = tableView.dequeueReusableCell(for: indexPath) as SpecialViewListTableViewCell
            cell.setup(
                title: item.title,
                discription: item.discription
            )
            return cell
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        titleForHeaderInSection section: Int
    ) -> String? {
        let listSection = viewModel.listSections[section]
        switch listSection {
        case .customView:
            return listSection.title
        }
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
        switch listSection {
        case .customView:
            openView(
                listItem: listSection.items[indexPath.row]
            )
        }
    }
}

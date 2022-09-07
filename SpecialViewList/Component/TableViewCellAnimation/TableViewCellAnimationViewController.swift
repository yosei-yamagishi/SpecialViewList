import UIKit

class TableViewCellAnimationViewController: UIViewController {

    private var viewModel: TableViewCellAnimationViewModel
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.registerNib(
                cellType: CellAnimationTableViewCell.self
            )
        }
    }
    
    init(viewModel: TableViewCellAnimationViewModel) {
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

extension TableViewCellAnimationViewController: UITableViewDataSource {
    
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        viewModel.sections.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch viewModel.sections[section] {
        case .section1:
            return viewModel.section1Titles.count
        case .section2:
            return viewModel.section2Titles.count
        case .section3:
            return viewModel.section3Titles.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch viewModel.sections[indexPath.section] {
        case .section1:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CellAnimationTableViewCell
            cell.set(
                title: viewModel.section1Titles[indexPath.row]
            )
            return cell
        case .section2:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CellAnimationTableViewCell
            cell.set(
                title: viewModel.section2Titles[indexPath.row]
            )
            return cell
        case .section3:
            let cell = tableView.dequeueReusableCell(for: indexPath) as CellAnimationTableViewCell
            cell.set(
                title: viewModel.section3Titles[indexPath.row]
            )
            return cell
        }
    }
}


extension TableViewCellAnimationViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let headerView = CellAnimationHeaderView()
        headerView.frame = CGRect(
            origin: .zero,
            size: CellAnimationHeaderView.headerSize
        )
        headerView.setHeaderTitle(
            title: "タイトル" + section.description,
            section: section,
            isHiddenContents: viewModel.isHiddenContents(section: section)
        )
        headerView.delegate = self
        return headerView
    }
}

extension TableViewCellAnimationViewController: CellAnimationHeaderViewDelegate {
    func didTapHeader(section: Int) {
        viewModel.updateTitles(section: section)
        tableView.reloadData()
    }
}

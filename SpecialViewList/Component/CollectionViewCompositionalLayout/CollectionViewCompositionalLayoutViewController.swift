import UIKit

class CollectionViewCompositionalLayoutViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            let nibs = [
                ContentCollectionViewCell.self,
                ImageCollectionViewCell.self,
                OverviewWithToggleCollectionViewCell.self
            ]
            collectionView.registerNib(
                cellTypes: nibs
            )
            collectionView.collectionViewLayout = collectionLayout
        }
    }
    
    private var collectionLayout: UICollectionViewCompositionalLayout {
        let sectionProvider = { [weak self] (section: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            let sectionType = self.viewModel.state.sections[section]
            switch sectionType {
            case .thumbnail:
                let collecitonWidth = layoutEnvironment.container.contentSize.width
                let thumbnailHeight = min(
                    collecitonWidth * (9/16),
                    360
                )
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(thumbnailHeight)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: itemSize,
                    subitem: item,
                    count: 1
                )
                let layoutSection = NSCollectionLayoutSection(group: group)
                return layoutSection
            case .titleText:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(56)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: itemSize,
                    subitem: item,
                    count: 1
                )
                let layoutSection = NSCollectionLayoutSection(group: group)
                return layoutSection
            case .overview:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(120)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: itemSize,
                    subitem: item,
                    count: 1
                )
                let layoutSection = NSCollectionLayoutSection(group: group)
                return layoutSection
            case .content:
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(44)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: itemSize,
                    subitem: item,
                    count: 1
                )
                let layoutSection = NSCollectionLayoutSection(group: group)
                return layoutSection
            }
        }
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider
        )
    }
    
    private let viewModel: CollectionViewCompositionalLayoutViewModel
    
    init(
        viewModel: CollectionViewCompositionalLayoutViewModel
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
        navigationItem.largeTitleDisplayMode = .never
        viewModel.send(.viewDidLoad)
    }

}

extension CollectionViewCompositionalLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.state.sections.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        let sectionType = viewModel.state.sections[section]
        switch sectionType {
        case .thumbnail:
            return 1
        case .titleText:
            return 1
        case .overview:
            return 1
        case .content:
            return viewModel.state.contentDetail.contents.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let sectionType = viewModel.state.sections[indexPath.section]
        switch sectionType {
        case .thumbnail:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ImageCollectionViewCell
            cell.setImage(
                fileName: viewModel.state.contentDetail.thumbnailFileName
            )
            return cell
        case .titleText:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentCollectionViewCell
            cell.set(
                titleText: viewModel.state.contentDetail.title
            )
            return cell
        case .overview:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as OverviewWithToggleCollectionViewCell
            let overview = viewModel.state.contentDetail.overview
            cell.setOverview(overview: overview)
            cell.delegate = self
            return cell
        case .content:
            let cell = collectionView.dequeueReusableCell(for: indexPath) as ContentCollectionViewCell
            let title = viewModel.state.contentDetail.contents[indexPath.item].title
            cell.set(titleText: title)
            return cell
        }
    }
}

extension CollectionViewCompositionalLayoutViewController: OverviewWithToggleCollectionViewCellDelegate {
    func didTapToggleOverview() {
        collectionView.reloadData()
    }
}

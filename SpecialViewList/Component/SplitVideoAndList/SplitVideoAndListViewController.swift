import UIKit
import Combine

class SplitVideoAndListViewModel: UDFViewModel {
    enum Action {
        case viewDidLoad
    }
    
    struct State: Equatable {
        var contents: [ItemContent] = []
    }
    
    @Published var state: State
    
    init(state: State = State()) {
        self.state = state
    }
    
    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            state.contents = ItemContent.listContents
        }
    }
}

class SplitVideoAndListViewController: UIViewController {

    @IBOutlet weak var holizontalCollectionView: UICollectionView! {
        didSet {
            let nibs = [SpllitVideoAndListCollectionViewCell.self]
            holizontalCollectionView.registerNib(cellTypes: nibs)
            holizontalCollectionView.dataSource = self
            holizontalCollectionView.delegate = self
            holizontalCollectionView.collectionViewLayout = collectionLayout
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nibs = [SpllitVideoAndListCollectionViewCell.self]
            collectionView.registerNib(cellTypes: nibs)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = collectionLayout
        }
    }
    
    @IBOutlet weak var fullScreenButton: UIButton! {
        didSet {
            fullScreenButton.addAction(
                rotateSreenViewAction(),
                for: .touchUpInside
            )
            fullScreenButton.setImage(
                UIImage(systemName: "arrow.up.left.and.arrow.down.right"),
                for: .normal
            )
        }
    }
    
    @IBOutlet weak var listHolizontalViewWidth: NSLayoutConstraint!
    
    private var collectionLayout: UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let sectionProvider = { (section: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(56)
            )
            let item = NSCollectionLayoutItem(
                layoutSize: itemSize
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: itemSize,
                subitem: item,
                count: 1
            )
            let layoutSection = NSCollectionLayoutSection(group: group)
            return layoutSection
        }
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: config
        )
    }
    private let viewModel: SplitVideoAndListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(
        viewModel: SplitVideoAndListViewModel
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
        bindViewModel()
        viewModel.send(.viewDidLoad)
    }
    
    private func bindViewModel() {
        viewModel.$state.map(\.contents)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] contents in
                guard let self else { return }
                self.collectionView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.switchList(isPortrait: self.isPortrait)
        self.setScreenStateView(isPortrait: self.isPortrait)
    }
    
    private func rotateSreenViewAction() -> UIAction {
        UIAction { [weak self] _ in
            guard let self = self else { return }
            let rotatedDeviceOrientation = self.isPortrait
                ? UIInterfaceOrientation.landscapeRight
                : UIInterfaceOrientation.portrait
            self.updateOrientaiton(
                deviceOrientation: rotatedDeviceOrientation
            )
        }
    }
    
    private func switchList(isPortrait: Bool) {
        self.collectionView.isHidden = isPortrait
        self.holizontalCollectionView.isHidden = !isPortrait
        
        if isPortrait {
            listHolizontalViewWidth.constant = 120
        } else {
            listHolizontalViewWidth.constant = .zero
        }
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setScreenStateView(isPortrait: Bool) {
        let systemName = isPortrait
            ? "arrow.down.forward.and.arrow.up.backward"
            : "arrow.up.left.and.arrow.down.right"
        let iconImage = UIImage(systemName: systemName)
        fullScreenButton.setImage(
            iconImage,
            for: .normal
        )
    }
}

extension SplitVideoAndListViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.state.contents.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as SpllitVideoAndListCollectionViewCell
        cell.setup(title: viewModel.state.contents[indexPath.item].name)
        return cell
    }
}

extension SplitVideoAndListViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
     return
    }
}

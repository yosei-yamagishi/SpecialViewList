import UIKit

class VideoOnCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let followLayout = UICollectionViewFlowLayout()
            followLayout.scrollDirection = .vertical
            followLayout.estimatedItemSize = CGSize(
                width: UIScreen.main.bounds.width,
                height: UICollectionViewFlowLayout.automaticSize.height
            )
            collectionView.collectionViewLayout = followLayout
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.isPagingEnabled = false
            collectionView.dataSource = self
            collectionView.delegate = self
            
            let nibs = [
                VideoPreviewCollectionViewCell.self,
                ContentCollectionViewCell.self
            ]
            collectionView.registerNib(cellTypes: nibs)
        }
    }
    
    private var viewModel: VideoOnCollectionViewModel
    private let videoPlayer: VideoPlayerProtocol
    
    init(
        viewModel: VideoOnCollectionViewModel,
        videoPlayer: VideoPlayerProtocol
    ) {
        self.viewModel = viewModel
        self.videoPlayer = videoPlayer
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        viewModel.initAndSetupPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.playVideo()
    }
}

extension VideoOnCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch viewModel.sections[section] {
        case .video: return 1
        case .contents: return viewModel.contents.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .video:
            let cell = collectionView.dequeueReusableCell(
                for: indexPath
            ) as VideoPreviewCollectionViewCell
            cell.setupPlayer(videoPlayer: videoPlayer)
            return cell
        case .contents:
            let cell = collectionView.dequeueReusableCell(
                for: indexPath
            ) as ContentCollectionViewCell
            cell.set(
                titleText: viewModel.contents[indexPath.item].name
            )
            return cell
        }
    }
}

extension VideoOnCollectionViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        switch viewModel.sections[indexPath.section] {
        case .contents:
            viewModel.addTextToContentName(indexPath: indexPath)
            collectionView.reloadSections(
                IndexSet(integer: indexPath.section)
            )
        default: break
        }
    }
}

extension VideoOnCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch viewModel.sections[indexPath.section] {
        case .video:
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.width * 9 / 16
            )
        case .contents:
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: 56
            )
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }
}

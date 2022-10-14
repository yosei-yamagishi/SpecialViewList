import UIKit

struct VideoPicutureAsset {
    var cgImage: CGImage
    var clipTime: Float
    
    var image: UIImage {
        UIImage(cgImage: cgImage)
    }
}

class ClippingPictureInVideoViewController: UIViewController {
    @IBOutlet weak var avPlayerControllerView: AVPlayerViewControllerView! {
        didSet {
            avPlayerControllerView.setupPlayerView()
            addChild(avPlayerControllerView.playerController)
            didMove(toParent: avPlayerControllerView.playerController)
        }
    }
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
                ClippingPictureAssetCollectionViewCell.self
            ]
            collectionView.registerNib(cellTypes: nibs)
        }
    }
    
    @IBOutlet weak var cilpPictureButton: UIButton! {
        didSet {
            cilpPictureButton.addAction(
                UIAction { [weak self] _ in
                    guard let self = self else { return }
                    self.viewModel.clipPicture()
                    self.collectionView.reloadData()
                },
                for: .touchUpInside
            )
        }
    }
    
    private var viewModel: ClippingPictureInVideoModel
    private let videoPlayer: VideoPlayerProtocol
    private var images: [UIImage] = []
    
    init(
        viewModel: ClippingPictureInVideoModel,
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
        setupAVPlayerController()
        viewModel.setupPictureClipper(
            viewSize: self.avPlayerControllerView.frame.size
        )
    }
    
    private func setupAVPlayerController() {
        avPlayerControllerView.setPlayer(player: videoPlayer.player)
    }
}

extension ClippingPictureInVideoViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        viewModel.videoPicutureAssets.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            for: indexPath
        ) as ClippingPictureAssetCollectionViewCell
        let videoPicutureAsset = viewModel.videoPicutureAssets[indexPath.item]
        cell.set(
            image: videoPicutureAsset.image,
            time: videoPicutureAsset.clipTime
        )
        return cell
    }
}

extension ClippingPictureInVideoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(
            width: UIScreen.main.bounds.width,
            height: 120
        )
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

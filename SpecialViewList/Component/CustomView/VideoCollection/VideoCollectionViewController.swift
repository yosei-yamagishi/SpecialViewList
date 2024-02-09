import UIKit
import Combine

class VideoCollectionViewController: UIViewController {
    
    @IBOutlet weak var videoCollectionView: VideoCollectionView! {
        didSet {
            videoCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var muteButton: UIButton! {
        didSet {
            let action = UIAction { [weak self] _ in
                self?.viewModel.mute()
            }
            muteButton.addAction(
                action,
                for: .touchUpInside
            )
            muteButton.allMaskCorner()
        }
    }
    private var cancellables = Set<AnyCancellable>()
    private let videoPlayer: VideoPlayerProtocol
    private let viewModel: VideoCollectionViewModel

    init(
        videoPlayer: VideoPlayerProtocol = VideoPlayer(),
        viewModel: VideoCollectionViewModel
    ) {
        self.videoPlayer = videoPlayer
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
        viewModel.initAndSetupPlayer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.largeTitleDisplayMode = .never
        
        videoCollectionView.setupVideos(
            videos: viewModel.videos
        )
        videoCollectionView.setupPlayer(
            avPlayer: videoPlayer.player
        )
        viewModel.playVideo()
    }
    
    private func bindViewModel() {
        viewModel.$isMuted
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isMuted in
                guard let self = self else { return }
                let muteImage = isMuted
                    ? UIImage(systemName: "speaker.slash")
                    : UIImage(systemName: "speaker.wave.2")
                self.muteButton.setImage(
                    muteImage,
                    for: .normal
                )
            }).store(in: &cancellables)
    }
}

extension VideoCollectionViewController: VideoCollectionViewDelegate {
    func didChangedCollectionPage(currentIndex: Int) {
        viewModel.initAndSetupPlayer(
            currentIndex: currentIndex
        )
        videoCollectionView.setupPlayer(
            avPlayer: videoPlayer.player
        )
        viewModel.playVideo()
    }
}

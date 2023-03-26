import UIKit

class DefaultAVPlayerViewController: UIViewController {
    
    @IBOutlet weak var avPlayerControllerView: AVPlayerViewControllerView! {
        didSet {
            avPlayerControllerView.setupPlayerView()
            addChild(avPlayerControllerView.playerController)
            didMove(toParent: avPlayerControllerView.playerController)
        }
    }
    
    private let viewModel: DefaultAVPlayerViewModel
    private let videoPlayer: VideoPlayerProtocol
    
    init(
        videoPlayer: VideoPlayerProtocol,
        viewModel: DefaultAVPlayerViewModel
    ) {
        self.videoPlayer = videoPlayer
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setupPlayer()
        setupAVPlayerController()
        viewModel.playbackVideo()
    }
    
    private func setupAVPlayerController() {
        avPlayerControllerView.setPlayer(player: videoPlayer.player)
    }
}

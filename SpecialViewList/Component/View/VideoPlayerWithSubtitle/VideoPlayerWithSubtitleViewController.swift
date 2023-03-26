import UIKit
import Combine

class VideoPlayerWithSubtitleViewController: UIViewController {
    
    @IBOutlet weak var videoSubtitleListView: VideoSubtitleListView! {
        didSet {
            videoSubtitleListView.delegate = self
        }
    }
    @IBOutlet weak var videoWithControlView: VideoWithControlView! {
        didSet {
            videoWithControlView.controlDelegate = self
        }
    }
    
    private let viewModel: VideoPlayerWithSubtitleViewModel
    private let videoPlayer: VideoPlayerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(
        viewModel: VideoPlayerWithSubtitleViewModel,
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
        bindViewModel()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = .createCloseBarButtonItem { [weak self] _ in
            guard let self else { return }
            self.dismiss(animated: true)
        }
        viewModel.send(.viewDidLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        videoWithControlView.setupPlayer(
            avPlayer: videoPlayer.player
        )
    }
    
    private func bindViewModel() {
        viewModel.$state.map(\.subtitleInfoList)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] subtitleInfoList in
                guard let self else { return }
                self.videoSubtitleListView.updateContents(
                    subtitleInfoList: subtitleInfoList
                )
            })
            .store(in: &cancellables)
        
        viewModel.$state.map(\.isPlaying)
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isPlaying in
                guard let self else { return }
                self.videoWithControlView.switchPlayAndPauseButton(
                    isPlaying: isPlaying
                )
                if isPlaying {
                    self.videoWithControlView.activateControlViewHiddenTimer()
                }
            })
            .store(in: &cancellables)
        
        viewModel.$state.map(\.duration)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] duration in
                guard let self else { return }
                self.videoWithControlView.setDuration(duration: duration)
            })
            .store(in: &cancellables)
        
        viewModel.$state.map(\.currentSeconds)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] currentSeconds in
                guard let self else { return }
                self.videoWithControlView.setCurrentTime(
                    currentTime: currentSeconds
                )
            })
            .store(in: &cancellables)
        
        viewModel.$state.map(\.activeScrollIndexPath)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] indexPath in
                guard let self else { return }
                    self.videoSubtitleListView.updateActivateIndex(indexPath:  indexPath)
                }
            )
            .store(in: &cancellables)
    }
}

extension VideoPlayerWithSubtitleViewController: VideoControlDelegate {
    func didTapPlayAndPause() {
        viewModel.send(.didTapPlayAndPause)
    }
    
    func didTapForward() {
        viewModel.send(.didTapForward)
    }
    
    func didTapBackward() {
        viewModel.send(.didTapBackward)
    }
    
    func didTapFullScreen() {
        viewModel.send(.didTapFullScreen)
    }
    
    func didTapSpeedRate() {
        
        viewModel.send(.didTapSpeedRate)
    }
    
    func didTapDownSeekBar(
        currentTime: Float
    ) {
        viewModel.send(
            .didTapDownSeekBar(currentTime: currentTime)
        )
    }
    
    func didTapUpInsideOrOutsideSeekBar(
        currentTime: Float
    ) {
        viewModel.send(
            .didTapUpInsideOrOutsideSeekBar(
                currentTime: currentTime
            )
        )
    }
    
    func didTapSeekBar(currentTime: Float) {
        viewModel.send(
            .didTapSeekBar(currentTime: currentTime)
        )
    }
}

extension VideoPlayerWithSubtitleViewController: VideoSubtitleListViewDelegate {
    func didSelectSubtitle(indexPath: IndexPath) {
        viewModel.send(
            .didSelectSubtitle(indexPath: indexPath)
        )
    }
}

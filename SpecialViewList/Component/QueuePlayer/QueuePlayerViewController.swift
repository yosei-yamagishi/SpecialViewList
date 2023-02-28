import Combine
import AVFoundation
import UIKit

class QueuePlayerViewController: UIViewController {

    @IBOutlet weak var videoOnControlView: VideoOnControlView! {
        didSet {
            videoOnControlView.controlDelegate = self
            videoOnControlView.setupPlayer(
                videoQueuePlayer: videoQueuePlayer
            )
        }
    }
    private let videoQueuePlayer: VideoQueuePlayer
    private let viewModel: QueuePlayerViewModel
    private var cancellables = Set<AnyCancellable>()
    private var playerTimer: Timer?
    
    init(
        viewModel: QueuePlayerViewModel,
        videoQueuePlayer: VideoQueuePlayer
    ) {
        self.videoQueuePlayer = videoQueuePlayer
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindState()
        viewModel.send(.viewDidLoad)
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bindState() {
        viewModel.$state.map(\.playerVideoItems)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] videos in
                guard let self else { return }
                self.videoOnControlView.setupPlayer(
                    videoQueuePlayer: self.videoQueuePlayer
                )
            }
            .store(in: &cancellables)
        
        viewModel.$state.map(\.videoDuration)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] videoDuration in
                guard let self else { return }
                self.videoOnControlView.setTotalTime(
                    totalTime: videoDuration
                )
            }
            .store(in: &cancellables)
        
        viewModel.$state.map(\.videoCurrentTime)
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentTime in
                guard let self else { return }
                self.videoOnControlView.setCurrentTime(
                    currentTime: currentTime
                )
            }
            .store(in: &cancellables)
    }
    
    private func startTimer() {
        playerTimer = Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true
        ) { [weak self] timer in
            guard let self else { return }
            self.viewModel.send(.updateCurrentTime)
        }
    }
}

extension QueuePlayerViewController: VideoControlViewDelegate {
    func didTapPlayAndPause() {
        viewModel.send(.didTapPlayAndPause)
    }
    
    func didTapForward() {
        viewModel.send(.didTapForward)
    }
    
    func didTapBack() {
        viewModel.send(.didTapBack)
    }
    
    func didTapDownSeekBar(currentTime: Float) {
        viewModel.send(
            .didTapDownSeekBar(currentTime: currentTime)
        )
    }
}

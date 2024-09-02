import UIKit
import Combine
import AVFoundation

struct ThumbnailImageGenerator {
    private let asset: AVAsset
    private let generator: AVAssetImageGenerator
    
    init(url: URL) {
        asset = AVAsset(url: url)
        generator = AVAssetImageGenerator (asset: asset)
    }
    
    func updateThumbnail(currentTime: Float) async throws -> UIImage? {
        if #available(iOS 16, *) {
            let time = CMTime(
                seconds: Double(currentTime),
                preferredTimescale: 1
            )
            let thumbnail = try await generator.image(at: time).image
            generator.requestedTimeToleranceBefore = .zero
            generator.requestedTimeToleranceAfter = .zero
            return UIImage (cgImage: thumbnail)
        } else {
           return nil
        }
    }
}

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
    private var thumbnailImageGenerator: ThumbnailImageGenerator?
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
        viewModel.$state.map(\.videoUrl)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] videoUrl in
                guard let self else { return }
                self.thumbnailImageGenerator = ThumbnailImageGenerator(url: videoUrl)
            })
            .store(in: &cancellables)
        
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
        
        viewModel.$state.map(\.speedRateInfo)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] speedRateInfo in
                guard let self else { return }
                guard let currentSpeedRate = speedRateInfo?.first(where: { $0.value })?.key else {
                    return
                }
                let speeds = speedRateInfo?.keys.sorted() ?? []
                self.videoWithControlView.setupSpeedButton(
                    currentSpeed: currentSpeedRate,
                    speeds: speeds
                )
            })
            .store(in: &cancellables)
    }
}

extension VideoPlayerWithSubtitleViewController: VideoControlDelegate {
    func didChangedPlayTime(currentTime: Float) {
        Task.detached {
            do {
                let image = try await self.thumbnailImageGenerator?.updateThumbnail(
                    currentTime: currentTime
                )
                await self.videoWithControlView.updateImage(
                    image: image
                )
            }
        }
    }
    
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
    
    func didTapSpeedRate(speed: Double) {
        viewModel.send(.didTapSpeedRate(speed: speed))
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

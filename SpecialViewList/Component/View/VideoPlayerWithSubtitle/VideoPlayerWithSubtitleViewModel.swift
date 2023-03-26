import Combine
import Foundation

class VideoPlayerWithSubtitleViewModel: UDFViewModel {
    static let timeInterval: TimeInterval = 0.1
    
    enum Action {
        case viewDidLoad
        case didTapPlayAndPause
        case didTapForward
        case didTapBackward
        case didTapFullScreen
        case didTapSpeedRate
        case didTapDownSeekBar(currentTime: Float)
        case didTapUpInsideOrOutsideSeekBar(currentTime: Float)
        case didTapSeekBar(currentTime: Float)
        case didSelectSubtitle(indexPath: IndexPath)
    }
    
    struct State: Equatable {
        var subtitleInfoList: [SubtitleInfo] = []
        var isPlaying: Bool = false
        var duration: Float = .zero
        var currentSeconds: Float?
        var activeScrollIndexPath: IndexPath?
    }

    @Published private(set) var state: State
    private var videoPlayer: VideoPlayerControlProtocol
    
    init(
        state: State = State(),
        videoPlayer: VideoPlayerControlProtocol
    ) {
        self.state = state
        self.videoPlayer = videoPlayer
        self.videoPlayer.delegate = self
    }
    
    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            state.subtitleInfoList = SubtitleInfo.videoSampleList
            let url = Bundle.main.bundleURL
                .appendingPathComponent(
                    Sample.cloudSpeechToTextMovie
                )
            videoPlayer.prepare(url: url)
            videoPlayer.startObservePlayerTimer()
            state.duration = videoPlayer.duration
        case .didTapPlayAndPause:
            videoPlayer.isPlaying
                ? videoPlayer.pause()
                : videoPlayer.play()
            state.isPlaying = videoPlayer.isPlaying
        case .didTapForward:
            videoPlayer.skipForward()
        case .didTapBackward:
            videoPlayer.skipBackward()
        case .didTapFullScreen:
            break
        case .didTapSpeedRate:
            //videoPlayer.setPlaybackRate(rate: )
            break
        case let .didTapDownSeekBar(currentTime: currentTime):
            videoPlayer.setCurrentTime(currentTime: currentTime)
        case let .didTapUpInsideOrOutsideSeekBar(currentTime: currentTime):
            videoPlayer.setCurrentTime(currentTime: currentTime)
        case let .didTapSeekBar(currentTime: currentTime):
            videoPlayer.setCurrentTime(currentTime: currentTime)
        case let .didSelectSubtitle(indexPath: indexPath):
            let selectedSubtitle = state.subtitleInfoList[indexPath.item]
            videoPlayer.setCurrentTime(
                currentTime: Float(selectedSubtitle.startTime)
            )
        }
    }
}

extension VideoPlayerWithSubtitleViewModel: VideoPlayerDelegate {
    func didPlayToEndTime() {
        
    }
    
    func didPostIntervalTime(currentTime: Float) {
        state.currentSeconds = currentTime
        if let index = self.state.subtitleInfoList.firstIndex(
            where: { $0.isActive(
                currentTime: Double(currentTime)
            )}
        ) {
            let indexPath = IndexPath(row: index, section: 0)
            if self.state.activeScrollIndexPath != indexPath {
                self.state.activeScrollIndexPath = indexPath
            }
        }
    }
}

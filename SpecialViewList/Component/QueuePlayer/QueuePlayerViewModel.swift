import Combine

class QueuePlayerViewModel: UDFViewModel {
    
    enum Action {
        case viewDidLoad
        case didTapPlayAndPause
        case didTapForward
        case didTapBack
        case didTapDownSeekBar(currentTime: Float)
        case updateCurrentTime
    }
    
    struct State: Equatable {
        var playerVideoItems: [QueuePlayerVideoItem] = []
        var currentVideoItemIndex: Int = 0 {
            didSet {
                updateDuration()
            }
        }

        var isPlaying: Bool = false
        var videoCurrentTime: Float = 0
        var videoDuration: Float = 0
        
        var currentPlayingVideoItem: QueuePlayerVideoItem {
            playerVideoItems[currentVideoItemIndex]
        }
        
        mutating func updateNextVideoItemIndex() {
            print("########")
            print(currentVideoItemIndex)
            print(playerVideoItems.endIndex)
            if currentVideoItemIndex == playerVideoItems.endIndex {
                return
            }
            currentVideoItemIndex += 1
        }
        
        mutating private func updateDuration() {
            videoDuration = currentPlayingVideoItem.video.videoDuration
        }
    }
    
    @Published var state: State
    private var videoQueuePlayer: VideoQueuePlayerControl
    
    init(
        state: State = State(),
        videoQueuePlayer: VideoQueuePlayerControl
    ) {
        self.state = state
        self.videoQueuePlayer = videoQueuePlayer
        videoQueuePlayer.delegate = self
    }
    
    func send(_ action: Action) {
        switch action {
        case .viewDidLoad:
            fetchVideos()
        case .didTapPlayAndPause:
            videoQueuePlayer.play(isMuted: false)
        case .didTapForward:
            videoQueuePlayer.skipForwardTenseconds()
        case .didTapBack:
            videoQueuePlayer.skipBackTenSeconds()
        case let .didTapDownSeekBar(currentTime: currentTime):
            videoQueuePlayer.seek(time: currentTime)
        case .updateCurrentTime:
            state.videoCurrentTime = videoQueuePlayer.currentTime
        }
    }
    
    private func fetchVideos() {
        state.playerVideoItems = Video.sampleVideos().map {
            QueuePlayerVideoItem(video: $0)
        }
        state.currentVideoItemIndex = 0
        videoQueuePlayer.prepare(
            playerItems: state.playerVideoItems.map { $0.item }
        )
        videoQueuePlayer.play(isMuted: false)
    }
}

extension QueuePlayerViewModel: VideoQueuePlayerDelegate {
    func didPlayToEndTime() {
        state.updateNextVideoItemIndex()
    }
}

import AVFoundation

protocol VideoPlayerProtocol {
    var player: AVPlayer? { get }
}

protocol VideoPlayerControlProtocol {
    var isPlaying: Bool { get }
    var currentTime: Float { get }
    var duration: Float { get }
    var delegate: VideoPlayerDelegate? { get set }
    var currentSpeedRateInfo: [Double: Bool] { get }
    func play()
    func pause()
    func skipForward()
    func skipBackward()
    func setPlaybackRate(rate: Float)
    func setCurrentTime(currentTime: Float)
    func startObservePlayerTimer()
    func play(isMuted: Bool)
    func pauseAndInit()
    func mute(isMuted: Bool)
    func prepare(url: URL)
}

protocol VideoPlayerDelegate: AnyObject {
    func didPlayToEndTime()
    func didPostIntervalTime(currentTime: Float)
}

class VideoPlayer: VideoPlayerProtocol, VideoPlayerControlProtocol {
    static let timeInterval: TimeInterval = 0.1
    static let skipInterval: Float = 10.0
    
    enum PlaybackRate: Float, CaseIterable {
        static let defaultPlaybackRate: PlaybackRate = .speed100

        case speed075 = 0.75
        case speed100 = 1.0
        case speed125 = 1.25
        case speed150 = 1.5
        case speed175 = 1.75
        case speed200 = 2.0
    }

    private var timerObserver: Any?
    var delegate: VideoPlayerDelegate?
    var player: AVPlayer?
    
    private var currentSpeedRate: Double {
        let rate = player?.rate ?? .zero
        if rate == .zero {
           return Double(PlaybackRate.defaultPlaybackRate.rawValue)
        }
        return Double(rate)
    }
    private var speedRates: [Double] = PlaybackRate.allCases.map { Double($0.rawValue) }
    var currentSpeedRateInfo: [Double: Bool] {
        var info = [Double: Bool]()
        for rate in speedRates {
            info[rate] = (rate == currentSpeedRate)
        }
        return info
    }
    
    var isPlaying: Bool { player?.isPlaying ?? false }

    var currentTime: Float {
        Float(player?.currentItem?.currentTime().seconds ?? .zero)
    }
    var duration: Float {
        Float(player?.currentItem?.asset.duration.seconds ?? .zero)
    }
    
    func prepare(url: URL) {
        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
        if #available(iOS 16.0, *) {
            player?.defaultRate = PlaybackRate.defaultPlaybackRate.rawValue
        } else {
            // Fallback on earlier versions
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func play(isMuted: Bool) {
        mute(isMuted: isMuted )
        player?.play()
    }
    
    func pauseAndInit() {
        player?.pause()
        player?.replaceCurrentItem(with: nil)
        if let timerObserver {
            player?.removeTimeObserver(
                timerObserver
            )
            self.timerObserver = nil
        }
        player = nil
        delegate = nil
    }
    
    func mute(isMuted: Bool) {
        player?.volume = isMuted ? 0 : 1
    }
    
    func skipForward() {
        let skipedTime = min(
            currentTime + Self.skipInterval,
            duration
        )
        setCurrentTime(currentTime: skipedTime)
    }

    func skipBackward() {
        let skipedTime = max(
            currentTime - Self.skipInterval,
            .zero
        )
        setCurrentTime(currentTime: skipedTime)
    }

    func setCurrentTime(currentTime: Float) {
        player?.seek(
            to: CMTimeMakeWithSeconds(
                Float64(currentTime),
                preferredTimescale: Int32(NSEC_PER_SEC)
            ),
            toleranceBefore: CMTime.zero,
            toleranceAfter: CMTime.zero
        )
    }
    
    func setPlaybackRate(rate: Float) {
        player?.rate = rate
    }
    
    func startObservePlayerTimer() {
        let intervalTime = CMTimeMakeWithSeconds(
            Self.timeInterval,
            preferredTimescale: Int32(NSEC_PER_SEC)
        )
        timerObserver = player?.addPeriodicTimeObserver(
            forInterval: intervalTime,
            queue: nil,
            using: { [weak self] _ in
                guard let self else { return }
                self.delegate?.didPostIntervalTime(
                    currentTime: self.currentTime
                )
            }
        )
    }
}

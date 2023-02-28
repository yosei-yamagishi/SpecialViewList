import Foundation
import AVFoundation
import Combine

struct QueuePlayerVideoItem: Equatable {
    let video: Video
    
    var item: AVPlayerItem {
        AVPlayerItem(
            url: video.videoUrl!
        )
    }
}

protocol VideoQueuePlayerDelegate: AnyObject {
    func didPlayToEndTime()
}

protocol VideoQueuePlayer {
    var player: AVQueuePlayer { get }
}

protocol VideoQueuePlayerControl: AnyObject {
    var delegate: VideoQueuePlayerDelegate? { get set }
    var isPlaying: Bool { get }
    var currentTime: Float { get }
    var duration: Float { get }
    func prepare(playerItems: [AVPlayerItem])
    func play(isMuted: Bool)
    func pause()
    func seek(time: Float)
    func skipBackTenSeconds()
    func skipForwardTenseconds()
    func mute(isMuted: Bool)
    func advanceToNextItem()
}

class VideoQueuePlayerImpl: VideoQueuePlayer, VideoQueuePlayerControl {
    weak var delegate: VideoQueuePlayerDelegate?
    private let notificationCenter: NotificationCenter = .default
    private var cancellables = Set<AnyCancellable>()
    private var queuePlayer = AVQueuePlayer()
    private var currentItem: AVPlayerItem? {
        player.currentItem
    }

    var player: AVQueuePlayer {
        queuePlayer
    }
    
    var currentTime: Float {
        Float(currentItem?.currentTime().seconds ?? .zero)
    }
    
    var duration: Float {
        Float(currentItem?.duration.seconds ?? .zero)
    }
    
    var isPlaying: Bool {
        queuePlayer.isPlaying
    }

    func prepare(playerItems: [AVPlayerItem]) {
        queuePlayer = AVQueuePlayer(items: playerItems)
        notificationCenter.publisher(
            for: .AVPlayerItemDidPlayToEndTime
        ).sink { notification in
            self.didPlayToEndTime(
                notification: notification
            )
        }
        .store(in: &cancellables)
    }
    
    func play(isMuted: Bool) {
        queuePlayer.play()
    }
    
    func pause() {
        queuePlayer.pause()
    }
    
    func seek(time: Float) {
        queuePlayer.seek(
            to: CMTime(value: CMTimeValue(time), timescale: 1)
        )
    }
    
    func mute(isMuted: Bool) {
        queuePlayer.volume = isMuted ? 0 : 1
    }
    
    func skipBackTenSeconds() {
        guard let currentItem else { return }
        let currentTime = max(
            min(
                currentItem.duration.seconds,
                currentItem.currentTime().seconds - 10.0
            ),
            .zero
        )
        let time = CMTime(
            seconds: currentTime,
            preferredTimescale: 1
        )
        queuePlayer.seek(to: time)
    }
    
    func skipForwardTenseconds() {
        guard let currentItem else { return }
        let currentTime = max(
            min(
                currentItem.duration.seconds,
                currentItem.currentTime().seconds + 10.0
            ),
            .zero
        )
        let time = CMTime(
            seconds: currentTime,
            preferredTimescale: 1
        )
        queuePlayer.seek(to: time)
    }
    
    func advanceToNextItem() {
       queuePlayer.advanceToNextItem()
    }
    
    private func didPlayToEndTime(
        notification: Notification
    ) {
        guard let playerItem = notification.object as? AVPlayerItem else { return }
        print("## duration", playerItem.duration.seconds)
        print("## current", currentItem?.duration.seconds)
        
        print(queuePlayer.items().firstIndex(of: playerItem))
        print(queuePlayer.items().count)
        
        delegate?.didPlayToEndTime()
    }
}

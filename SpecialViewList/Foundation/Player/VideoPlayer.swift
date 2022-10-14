import AVFoundation

protocol VideoPlayerProtocol {
    var player: AVPlayer? { get }
}

protocol VideoPlayerControlProtocol {
    var isPlaying: Bool { get }
    var currentTime: Float { get }
    func play(isMuted: Bool)
    func pauseAndInit()
    func mute(isMuted: Bool)
    func prepare(url: URL)
}

class VideoPlayer: VideoPlayerProtocol, VideoPlayerControlProtocol {
    var player: AVPlayer?
    var isPlaying: Bool { player?.isPlaying ?? false }
    var currentTime: Float {
        Float(player?.currentTime().seconds ?? .zero)
    }

    func prepare(url: URL) {
        let item = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: item)
    }
    
    func play(isMuted: Bool) {
        mute(isMuted: isMuted )
        player?.play()
    }
    
    func pauseAndInit() {
        player?.pause()
        player = nil
    }
    
    func mute(isMuted: Bool) {
        player?.volume = isMuted ? 0 : 1
    }
}

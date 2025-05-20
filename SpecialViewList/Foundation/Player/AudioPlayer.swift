import AVFoundation

protocol AudioPlayerProtocol {
    var currentTime: Double { get }
    var isPlaying: Bool { get }
    func setup(url: URL)
    func play()
    func pause()
    func updateTime(currentTime: Double)
    func skipBack()
    func skipForward()
}

class AudioPlayer: AudioPlayerProtocol {
    static private let skipTime: Double = 10
    
    private var audioPlayer: AVAudioPlayer?
    
    private var duration: Double {
        audioPlayer?.duration ?? 0
    }
    
    var currentTime: Double {
        audioPlayer?.currentTime ?? 0
    }
    
    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
    }

    func setup(url: URL) {
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.prepareToPlay()
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func updateTime(currentTime: Double) {
        audioPlayer?.currentTime = currentTime
    }

    func skipBack() {
        guard let player = audioPlayer else { return }
        let newTime = max(player.currentTime - Self.skipTime, 0)
        player.currentTime = newTime
    }

    func skipForward() {
        guard let player = audioPlayer else { return }
        let newTime = min(player.currentTime + Self.skipTime, player.duration)
        player.currentTime = newTime
    }
}


import  Foundation

class DefaultAVPlayerViewModel {
    private var videoPlayer: VideoPlayerControlProtocol
    private let videoUrl: URL = Bundle.main.bundleURL
        .appendingPathComponent( "movie1.mp4")
    
    init(
        videoPlayer: VideoPlayerControlProtocol
    ) {
        self.videoPlayer = videoPlayer
    }
    
    func setupPlayer() {
        videoPlayer.prepare(url: videoUrl)
    }
    
    func playbackVideo() {
        videoPlayer.play(isMuted: true)
    }
}

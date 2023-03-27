import Foundation
import Combine

class VideoCollectionViewModel {
    @Published private(set) var isMuted: Bool = false
    
    private var videoPlayer: VideoPlayerControlProtocol
    private(set) var videos: [Video] = Video.sampleVideos()
    
    init(
        videoPlayer: VideoPlayerControlProtocol = VideoPlayer()
    ) {
        self.videoPlayer = videoPlayer
    }
    
    func mute() {
        isMuted.toggle()
        videoPlayer.mute(isMuted: isMuted)
    }
    
    func initAndSetupPlayer(currentIndex: Int = 0) {
        videoPlayer.pauseAndInit()
        let videoUrlString = videos[currentIndex].videoUrlString
        let url = Bundle.main.bundleURL
            .appendingPathComponent(videoUrlString)
        videoPlayer.prepare(url: url)
    }
    
    func playVideo() {
        videoPlayer.play(isMuted: isMuted)
    }
}

import Foundation
import AVFoundation

class PictureClipper {
    private let avAsset: AVURLAsset
    private let generator: AVAssetImageGenerator
    
    init(videoUrl: URL) {
        self.avAsset = AVURLAsset(url: videoUrl)
        self.generator = AVAssetImageGenerator(
            asset: avAsset
        )
    }
    
    func setSize(pictureSize: CGSize) {
        generator.maximumSize = pictureSize
    }
    
    func clipPicture(currentTime: Float) -> CGImage? {
        let capturingTime: CMTime = CMTimeMakeWithSeconds(
            Float64(currentTime),
            preferredTimescale: 1
        )
        guard let capturedImage = try? generator.copyCGImage(
            at: capturingTime,
            actualTime: nil
        ) else { return nil }
        
        return capturedImage
    }
}


class ClippingPictureInVideoModel {
    private var videoPlayer: VideoPlayerControlProtocol
    private(set) var videoPicutureAssets: [VideoPicutureAsset] = []
    private var video: Video = Video.sampleVideo2
    private var videoUrl: URL {
        Bundle.main.bundleURL.appendingPathComponent(
            video.videoUrlString
        )
    }
    private var pictureClipper: PictureClipper?
    
    init(
        videoPlayer: VideoPlayerControlProtocol
    ) {
        self.videoPlayer = videoPlayer
    }
    
    func initAndSetupPlayer() {
        videoPlayer.pauseAndInit()
        videoPlayer.prepare(url: videoUrl)
    }
    
    func playVideo() {
        videoPlayer.play(isMuted: false)
    }
    
    func setupPictureClipper(viewSize: CGSize) {
        self.pictureClipper = PictureClipper(videoUrl: videoUrl)
        pictureClipper?.setSize(pictureSize: viewSize)
    }
    
    func clipPicture() {
        let currentTime = videoPlayer.currentTime
        guard let capturedImage = pictureClipper?.clipPicture(
            currentTime: currentTime
        ) else { return }
        videoPicutureAssets.append(
            VideoPicutureAsset(
                cgImage: capturedImage,
                clipTime: currentTime
            )
        )
    }
}

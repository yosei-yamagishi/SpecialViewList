import Foundation
import Combine

class SubtitlePlayerViewModel {
    @Published private(set) var activeScrollIndexPath = IndexPath(row: 0, section: 0)
    @Published private(set) var subtitleInfoList: [SubtitleInfo] = []
    @Published private(set) var isPlaying: Bool = false
    
    static let timeInterval: TimeInterval = 0.1
    private let audioPlayer: AudioPlayerProtocol
    private let audioFileUrl = Bundle.main.bundleURL.appendingPathComponent("audio_tmp_30.m4a")
    private var timer: Timer?
    
    
    init(
        audioPlayer: AudioPlayerProtocol = AudioPlayer(),
        subtitleInfoList: [SubtitleInfo] = SubtitleInfo.sampleList
    ) {
        self.audioPlayer = audioPlayer
        self.subtitleInfoList = subtitleInfoList
    }
    
    func setupPlayer() {
        audioPlayer.setup(url: audioFileUrl)
    }
    
    func playOrPause() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            stopTimer()
        } else {
            audioPlayer.play()
            startTimer()
        }
        isPlaying = audioPlayer.isPlaying
    }
    
    func selectSubtitle(subtitleInfo: SubtitleInfo) {
        audioPlayer.updateTime(currentTime: subtitleInfo.startTime)
    }
}

extension SubtitlePlayerViewModel {
    private func startTimer() {
        let timer = Timer.scheduledTimer(
            withTimeInterval: Self.timeInterval,
            repeats: true
        ) { [weak self] timer in
            guard let self = self else { return }
            if !self.audioPlayer.isPlaying {
                self.stopTimer()
                self.isPlaying = false
                return
            }
            
            if let index = self.subtitleInfoList.firstIndex(
                where: { $0.isActive(currentTime: self.audioPlayer.currentTime) }
            ) {
                let indexPath = IndexPath(row: index, section: 0)
                if self.activeScrollIndexPath != indexPath {
                    self.activeScrollIndexPath = indexPath
                }
            }
        }
        self.timer = timer
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

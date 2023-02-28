import AVFAudio

protocol AudioSession: AnyObject {
    func activate()
    func deactivate()
}

final class AudioSessionImpl: AudioSession {
    static let shared = AudioSessionImpl()
    private let audioSession: AVAudioSession

    private init() {
        audioSession = .sharedInstance()
    }

    func activate() {
        do {
            try audioSession.setCategory(.playback)
            try audioSession.setActive(true)
        } catch {
            print(error)
        }
    }

    func deactivate() {
        do {
            try audioSession.setActive(false)
        } catch {
            print(error)
        }
    }
}

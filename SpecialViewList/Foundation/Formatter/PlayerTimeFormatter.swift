struct PlayerTimeFormatter {
    static func playTime(time: Double) -> String {
        let hour = Int(time / 3600)
        let minute = Int((time - Double(hour * 3600)) / 60)
        let second = Int(time - Double(hour * 3600 + minute * 60))
        return hour == 0
          ? String(format: "%02d:%02d", minute, second)
          : String(format: "%02d:%02d:%02d", hour, minute, second)
    }
}

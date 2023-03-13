extension Double {
    func toPlayTimeSeconds() -> String {
        let hour = Int(self / 3600)
        let minute = Int((self - Double(hour * 3600)) / 60)
        let second = Int(self - Double(hour * 3600 + minute * 60))
        return hour == 0
          ? String(format: "%02d:%02d", minute, second)
          : String(format: "%02d:%02d:%02d", hour, minute, second)
    }
}

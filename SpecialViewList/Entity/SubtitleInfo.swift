struct SubtitleInfo: Equatable {
    var subtitle: String
    var startTime: Double
    var endTime: Double
    
    func isActive(currentTime: Double) -> Bool {
        startTime <= currentTime && currentTime < endTime
    }
}

extension SubtitleInfo {
    static let sampleList: [SubtitleInfo] = [
        SubtitleInfo(subtitle: "あのドラマのような", startTime: 0.0, endTime: 2.5),
        SubtitleInfo(subtitle: "リアルの恋っていう", startTime: 2.5, endTime: 5.2),
        SubtitleInfo(subtitle: "感じかは", startTime: 5.2, endTime: 6.0),
        SubtitleInfo(subtitle: "ちょっと", startTime: 6.0, endTime: 6.2),
        SubtitleInfo(subtitle: "わかんないけど", startTime: 6.2, endTime: 6.8),
        SubtitleInfo(subtitle: "俺はそう思ってないけど", startTime: 6.8, endTime: 9.2),
        SubtitleInfo(subtitle: "相手は思ってたみたいな", startTime: 9.2, endTime: 9.8),
        SubtitleInfo(subtitle: "そういう話ですけど", startTime: 9.8, endTime: 12.4),
        SubtitleInfo(subtitle: "あのー", startTime: 12.4, endTime: 13.7),
        SubtitleInfo(subtitle: "僕セブ島に留学してたことがあって", startTime: 13.7, endTime: 16.3),
        SubtitleInfo(subtitle: "あの結構", startTime: 16.3, endTime: 17.6),
        SubtitleInfo(subtitle: "あのーセブって", startTime: 17.6, endTime: 18.2),
        SubtitleInfo(subtitle: "結構", startTime: 18.2, endTime: 18.7),
        SubtitleInfo(subtitle: "フレンドリーなんですよ", startTime: 18.7, endTime: 19.6),
        SubtitleInfo(subtitle: "人が", startTime: 19.6, endTime: 20.6),
        SubtitleInfo(subtitle: "なんかいろいろ", startTime: 20.6, endTime: 21.3),
        SubtitleInfo(subtitle: "俺もなんか", startTime: 21.3, endTime: 22.1),
        SubtitleInfo(subtitle: "話しかけられたりしたら", startTime: 22.1, endTime: 23.4),
        SubtitleInfo(subtitle: "すぐfacebook", startTime: 23.4, endTime: 24.0),
        SubtitleInfo(subtitle: "交換して", startTime: 24.0, endTime: 25.3),
        SubtitleInfo(subtitle: "友達になって", startTime: 25.3, endTime: 26.1),
        SubtitleInfo(subtitle: "ある日", startTime: 26.1, endTime: 27.2),
        SubtitleInfo(subtitle: "そのカフェで", startTime: 27.2, endTime: 28.3),
        SubtitleInfo(subtitle: "勉強してたんですけど", startTime: 28.3, endTime: 30.0)
    ]
}

import Foundation

struct Video: Equatable {
    let thumbnailImageUrlString: String
    let videoUrlString: String
    let videoDuration: Float
    
    var videoUrl: URL? {
        Bundle.main.bundleURL
            .appendingPathComponent(videoUrlString)
    }
}

extension Video {
    static var sampleVideo: Video {
        Video(
            thumbnailImageUrlString: "thumbnail1",
            videoUrlString: "movie1.mp4",
            videoDuration: 9.0
        )
    }
    
    static func sampleVideos() -> [Video] {
        [
            Video(
                thumbnailImageUrlString: "thumbnail1",
                videoUrlString: "movie1.mp4",
                videoDuration: 9.0
            ),
            Video(
                thumbnailImageUrlString: "thumbnail2",
                videoUrlString: "movie2.mp4",
                videoDuration: 4.0
            ),
            Video(
                thumbnailImageUrlString: "thumbnail3",
                videoUrlString: "movie3.mp4",
                videoDuration: 7.0
            ),
            Video(
                thumbnailImageUrlString: "thumbnail4",
                videoUrlString: "movie4.mp4",
                videoDuration: 7.0
            ),
            Video(
                thumbnailImageUrlString: "thumbnail5",
                videoUrlString: "movie5.mp4",
                videoDuration: 8.0
            )
        ]
    }
}

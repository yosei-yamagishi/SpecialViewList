struct Video {
    let thumbnailImageUrlString: String
    let videoUrlString: String
}

extension Video {
    static func sampleVideos() -> [Video] {
        [
            Video(
                thumbnailImageUrlString: "thumbnail1",
                videoUrlString: "movie1.mp4"
            ),
            Video(
                thumbnailImageUrlString: "thumbnail2",
                videoUrlString: "movie2.mp4"
            ),
            Video(
                thumbnailImageUrlString: "thumbnail3",
                videoUrlString: "movie3.mp4"
            ),
            Video(
                thumbnailImageUrlString: "thumbnail4",
                videoUrlString: "movie4.mp4"
            ),
            Video(
                thumbnailImageUrlString: "thumbnail5",
                videoUrlString: "movie5.mp4"
            )
        ]
    }
}

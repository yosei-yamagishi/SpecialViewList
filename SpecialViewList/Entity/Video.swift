struct Video {
    let thumbnailImageUrlString: String
    let videoUrlString: String
}

extension Video {
    static var sampleVideo: Video {
        Video(
            thumbnailImageUrlString: Sample.thumbnailFileName1,
            videoUrlString: Sample.movie1
        )
    }
    
    static func sampleVideos() -> [Video] {
        [
            Video(
                thumbnailImageUrlString: Sample.thumbnailFileName1,
                videoUrlString: Sample.movie1
            ),
            Video(
                thumbnailImageUrlString: Sample.thumbnailFileName2,
                videoUrlString: Sample.movie2
            ),
            Video(
                thumbnailImageUrlString: Sample.thumbnailFileName3,
                videoUrlString: Sample.movie3
            ),
            Video(
                thumbnailImageUrlString: Sample.thumbnailFileName4,
                videoUrlString: Sample.movie4
            ),
            Video(
                thumbnailImageUrlString: Sample.thumbnailFileName5,
                videoUrlString: Sample.movie5
            )
        ]
    }
}

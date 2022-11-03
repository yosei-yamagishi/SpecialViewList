
struct CollectionContentDetail: Equatable {
    struct Content: Equatable {
        var imageFileName: String
        var title: String
    }
    var thumbnailFileName: String
    var title: String
    var overview: String
    var contents: [Content]
}

extension CollectionContentDetail {
    static let sample: CollectionContentDetail =
        CollectionContentDetail(
            thumbnailFileName: Sample.thumbnailFileName1,
            title: Sample.title,
            overview: Sample.overview1,
            contents: [
                Content(
                    imageFileName: Sample.thumbnailFileName1,
                    title: Sample.title1
                ),
                Content(
                    imageFileName: Sample.thumbnailFileName2,
                    title: Sample.title2
                ),
                Content(
                    imageFileName: Sample.thumbnailFileName3,
                    title: Sample.title3
                ),
                Content(
                    imageFileName: Sample.thumbnailFileName4,
                    title: Sample.title4
                ),
                Content(
                    imageFileName: Sample.thumbnailFileName5,
                    title: Sample.title5
                )
            ]
        )
}

import Foundation

class VideoOnCollectionViewModel {
    enum SectionType: CaseIterable {
        case video
        case contents
    }
    
    private var videoPlayer: VideoPlayerControlProtocol
    var sections: [SectionType] = SectionType.allCases
    var video: Video = Video.sampleVideo
    var contents: [ItemContent] = ItemContent.listContents
    
    init(
        videoPlayer: VideoPlayerControlProtocol
    ) {
        self.videoPlayer = videoPlayer
    }
    
    func initAndSetupPlayer() {
        videoPlayer.pauseAndInit()
        let videoUrlString = video.videoUrlString
        let url = Bundle.main.bundleURL
            .appendingPathComponent(videoUrlString)
        videoPlayer.prepare(url: url)
    }
    
    func playVideo() {
        videoPlayer.play(isMuted: false)
    }
    
    func addTextToContentName(indexPath: IndexPath) {
        let selectedName = contents[indexPath.item].name
        let selectedDefaultName = ItemContent.listContents[indexPath.item].name
        let additionalText = """
        \n追加分の文章がここに記述されていますのでよろしくおねがいします。結構長い文章でCellが展開されるのでその確認ができると思います。\n追加分の文章がここに記述されていますのでよろしくおねがいします。結構長い文章でCellが展開されるのでその確認ができると思います。
        """
        
        if selectedName.count == selectedDefaultName.count {
            contents[indexPath.item] = ItemContent(
                name: contents[indexPath.item] .name + additionalText
            )
        } else {
            contents[indexPath.item] = ItemContent(
                name: selectedDefaultName
            )
        }
    }
}

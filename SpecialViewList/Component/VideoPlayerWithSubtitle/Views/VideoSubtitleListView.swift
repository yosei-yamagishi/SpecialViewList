import UIKit

protocol VideoSubtitleListViewDelegate: AnyObject {
    func didSelectSubtitle(indexPath: IndexPath)
}

class VideoSubtitleListView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let nibs = [VideoSubtitleCollectionViewCell.self]
            collectionView.registerNib(cellTypes: nibs)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.collectionViewLayout = collectionLayout
        }
    }
    
    private var collectionLayout: UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        
        let sectionProvider = { (section: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(56)
            )
            let item = NSCollectionLayoutItem(
                layoutSize: itemSize
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: itemSize,
                subitem: item,
                count: 1
            )
            let layoutSection = NSCollectionLayoutSection(group: group)
            return layoutSection
        }
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider,
            configuration: config
        )
    }
    
    var delegate: VideoSubtitleListViewDelegate?
    private var timer: Timer?
    private var isAutoScroll: Bool = true
    private var isScrolling: Bool = false {
        didSet {
            if isScrolling {
                isAutoScroll = false
            } else {
                startTimer()
            }
        }
    }
    private var subtitleInfoList: [SubtitleInfo] = []
    private var activateIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func updateContents(subtitleInfoList: [SubtitleInfo]) {
        self.subtitleInfoList = subtitleInfoList
        collectionView.reloadData()
    }
    
    func updateActivateIndex(indexPath: IndexPath) {
        activateIndexPath = indexPath
        if isAutoScroll {
            scrollToRow(indexPath: indexPath)
        }
       // collectionView.reloadData()
    }
    
    private func scrollToRow(indexPath: IndexPath) {
        collectionView.scrollToItem(
            at: indexPath,
            at: .top,
            animated: true
        )
    }
    
    private func startTimer() {
        if timer != nil {
            return
        }
        timer = Timer.scheduledTimer(
            withTimeInterval: 5.0,
            repeats: false) { [weak self] timer in
                self?.isAutoScroll = true
                timer.invalidate()
                self?.timer = nil
            }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension VideoSubtitleListView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
       subtitleInfoList.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as VideoSubtitleCollectionViewCell
        let subtitleInfo = subtitleInfoList[indexPath.item]
        cell.setup(
            thumbnailImageName: subtitleInfo.thumbnailImageName,
            subtitle: subtitleInfo.subtitle,
            currentTime: subtitleInfo.startTime.toPlayTimeSeconds()
        )
        return cell
    }
}

extension VideoSubtitleListView: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        updateActivateIndex(indexPath: indexPath)
        delegate?.didSelectSubtitle(indexPath: indexPath)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if let cell = cell as? VideoSubtitleCollectionViewCell {
            cell.activateText(
                isActivated: indexPath == activateIndexPath
            )
        }
    }
}

extension VideoSubtitleListView {
    // スクロール中
    func scrollViewDidScroll(
        _ scrollView: UIScrollView
    ) {
        isScrolling = true
    }
    
    // ドラッグスクロール開始
    func scrollViewWillBeginDragging(
        _ scrollView: UIScrollView
    ) {
        isScrolling = true
    }
    
    // ドラッグスクロール終了
    func scrollViewDidEndDragging(
        _ scrollView: UIScrollView,
        willDecelerate decelerate: Bool
    ) {
        isScrolling = false
    }
    
    // 自然にスクロール終了
    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        isScrolling = false
    }
    
    // スクロール終了
    func scrollViewDidEndScrollingAnimation(
        _ scrollView: UIScrollView
    ) {
        isScrolling = false
    }
}

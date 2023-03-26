import UIKit
import AVKit

protocol VideoCollectionViewDelegate: AnyObject {
    func didChangedCollectionPage(currentIndex: Int)
}

class VideoCollectionView: UIView, NibOwnerLoadable {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let followLayout = UICollectionViewFlowLayout()
            followLayout.scrollDirection = collectionLayout.scrollDirection
            collectionView.collectionViewLayout = followLayout
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.isPagingEnabled = true
            collectionView.dataSource = self
            collectionView.delegate = self
            let nibs = [VideoCollectionViewCell.self]
            collectionView.registerNib(cellTypes: nibs)
        }
    }
    
    private var collectionLayout: CollectionLayout {
        CollectionLayout(
            scrollDirection: .horizontal,
            insets: .zero,
            minimumLineSpacing: 0,
            minimumInterItemSpacing: 0
        )
    }
    
    private var currentIndex: Int = 0 {
        didSet {
            if oldValue != currentIndex {
                delegate?.didChangedCollectionPage(
                    currentIndex: currentIndex
                )
            }
        }
    }
    
    private var isDragging: Bool = false
    
    private var cellSize: CGSize {
        collectionLayout.cellSize(type: .free(size: frame.size))
    }
    
    weak var delegate: VideoCollectionViewDelegate?
    private var videos: [Video] = []
    private var avPlayer: AVPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
    }
    
    func setupVideos(videos: [Video]) {
        self.videos = videos
        self.collectionView.reloadData()
    }
    
    func setupPlayer(avPlayer: AVPlayer?) {
        self.avPlayer = avPlayer
        self.collectionView.reloadData()
    }
}

extension VideoCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as VideoCollectionViewCell
        cell.setupThumbnailImage(
            urlString: videos[indexPath.item].thumbnailImageUrlString
        )
        if indexPath.item == currentIndex {
            cell.setupPlayer(avPlayer: avPlayer)
        } else {
            cell.removePlayer()
        }
        return cell
    }
}

extension VideoCollectionView: UICollectionViewDelegate {
    // 画面から指が離れたかつスクロールが自動停止した時
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(round(scrollView.contentOffset.x / cellSize.width))
    }
}

extension VideoCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionLayout.cellSize(type: .free(size: frame.size))
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        collectionLayout.insets
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionLayout.minimumInterItemSpacing
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        collectionLayout.minimumLineSpacing
    }
}

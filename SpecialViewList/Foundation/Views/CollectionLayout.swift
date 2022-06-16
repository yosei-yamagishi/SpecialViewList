import UIKit

struct CollectionLayout {
    enum CellSizeType {
        case free(size: CGSize)
        case squareOfFullScreen
        case square(length: CGFloat)
        case rectangle(length: CGFloat)
    }

    let deviceViewSize: CGSize
    let scrollDirection: UICollectionView.ScrollDirection
    let displayCount: CGFloat
    let nextContentDisplayWidth: CGFloat
    let insets: UIEdgeInsets
    let minimumLineSpacing: CGFloat // 垂直方向におけるセル間のマージン
    let minimumInterItemSpacing: CGFloat // 水平方向におけるセル間のマージン

    init(
        scrollDirection: UICollectionView.ScrollDirection,
        displayCount: CGFloat = 0,
        nextContentDisplayWidth: CGFloat = 0,
        insets: UIEdgeInsets,
        minimumLineSpacing: CGFloat,
        minimumInterItemSpacing: CGFloat,
        viewSize: CGSize = UIScreen.main.bounds.size
    ) {
        self.scrollDirection = scrollDirection
        self.displayCount = displayCount
        self.nextContentDisplayWidth = nextContentDisplayWidth
        self.insets = insets
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInterItemSpacing = minimumInterItemSpacing
        self.deviceViewSize = viewSize
    }

    private var verticalLength: CGFloat {
        (
            deviceViewSize.width
                - insets.left
                - insets.right
                - (minimumInterItemSpacing * (displayCount - 1))
        ) / displayCount
    }

    private var horizontalLength: CGFloat {
        (
            deviceViewSize.width
                - insets.left
                - nextContentDisplayWidth
                - (minimumInterItemSpacing * (displayCount - 1))
        ) / displayCount
    }

    func cellSize(type: CellSizeType) -> CGSize {
        switch type {
        case let .free(size: size):
            return size
        case .squareOfFullScreen:
            return CGSize(
                width: deviceViewSize.width,
                height: deviceViewSize.width
            )
        case let .square(length: length):
            return CGSize(width: length, height: length)
        case let .rectangle(length: length):
            return CGSize(width: horizontalLength, height: length)
        }
    }
}

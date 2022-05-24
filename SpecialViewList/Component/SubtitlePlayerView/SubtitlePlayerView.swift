import UIKit

protocol SubtitlePlayerViewDelegate: AnyObject {
    func didTapSubtitle(subtitleInfo: SubtitleInfo)
}

class SubtitlePlayerView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let nibs = [SubtitleTableViewCell.self]
            tableView.registerNib(cellTypes: nibs)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    weak var delegate: SubtitlePlayerViewDelegate?
    private var isScrolling: Bool = false
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
        tableView.reloadData()
    }
    
    func updateActivateIndex(indexPath: IndexPath) {
        activateIndexPath = indexPath
        if !isScrolling {
            scrollToRow(indexPath: indexPath)
        }
        tableView.reloadData()
    }
    
    private func scrollToRow(indexPath: IndexPath) {
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension SubtitlePlayerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subtitleInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SubtitleTableViewCell
        let subtitle = subtitleInfoList[indexPath.row].subtitle
        cell.setup(subtitle: subtitle)
        return cell
    }
}

extension SubtitlePlayerView: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        updateActivateIndex(indexPath: indexPath)
        delegate?.didTapSubtitle(
            subtitleInfo: subtitleInfoList[indexPath.row]
        )
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? SubtitleTableViewCell {
            cell.activateText(isActivated: indexPath == activateIndexPath)
        }
    }
}

extension SubtitlePlayerView {
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

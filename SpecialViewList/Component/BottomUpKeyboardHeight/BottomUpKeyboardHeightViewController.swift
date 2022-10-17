import UIKit
import Combine

class BottomUpKeyboardHeightViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let followLayout = UICollectionViewFlowLayout()
            followLayout.scrollDirection = .vertical
            followLayout.estimatedItemSize = CGSize(
                width: UIScreen.main.bounds.width,
                height: UICollectionViewFlowLayout.automaticSize.height
            )
            collectionView.collectionViewLayout = followLayout
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.isPagingEnabled = false
            collectionView.dataSource = self
            collectionView.delegate = self
            
            let nibs = [
                ContentCollectionViewCell.self,
                TextFieldCollectionViewCell.self
            ]
            collectionView.registerNib(cellTypes: nibs)
        }
    }
    
    @IBOutlet weak var collectionViewBottom: NSLayoutConstraint!
    private let notificationCenter: NotificationCenter = .default
    private var cancellables = Set<AnyCancellable>()
    
    private let viewModel: BottomUpKeyboardHeightViewModel
    
    init(
        viewModel: BottomUpKeyboardHeightViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        observeKeyboardNotification()
    }
    
    private func observeKeyboardNotification() {
        notificationCenter.publisher(
            for: UIApplication.keyboardWillShowNotification
        ).sink { notification in
            self.showKeyboard(notification)
        }
        .store(in: &cancellables)
        
        notificationCenter.publisher(
            for: UIApplication.keyboardWillHideNotification
        ).sink { notification in
            self.hideKeyboard(notification)
        }
        .store(in: &cancellables)
    }
    
    private func showKeyboard(_ notification: Notification) {
        let frameInfo = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        let durationInfo = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
        guard let frame = frameInfo as? NSValue,
              let duration: TimeInterval = durationInfo as? Double
        else {
            return
        }
        let heightConstant = frame.cgRectValue.size.height
        adjustTableViewBottom(
            keyboardHeight: heightConstant,
            duration: duration
        )
    }

    private func hideKeyboard(_ notification: Notification) {
        let durationInfo = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey]
        guard let duration: TimeInterval = durationInfo as? Double else {
            return
        }
        adjustTableViewBottom(
            keyboardHeight: 0,
            duration: duration
        )
    }
    
    private func adjustTableViewBottom(
        keyboardHeight: CGFloat,
        duration: TimeInterval
    ) {
        let safeAreaBottomHeight = self.view.safeAreaInsets.bottom
        let bottomConstant = keyboardHeight.isZero
            ? keyboardHeight
            : keyboardHeight - safeAreaBottomHeight
        
        if bottomConstant == collectionViewBottom.constant {
            return
        }
        
        collectionViewBottom.constant = bottomConstant
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}
extension BottomUpKeyboardHeightViewController: UICollectionViewDataSource {
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        switch viewModel.sections[section] {
        case .contents1: return viewModel.contents.count
        case .inputText1: return 1
        case .contents2: return viewModel.contents.count
        case .inputText2: return 1
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch viewModel.sections[indexPath.section] {
        case .contents1, .contents2:
            let cell = collectionView.dequeueReusableCell(
                for: indexPath
            ) as ContentCollectionViewCell
            cell.set(
                titleText: viewModel.contents[indexPath.item].name
            )
            return cell
        case .inputText1, .inputText2:
            let cell = collectionView.dequeueReusableCell(
                for: indexPath
            ) as TextFieldCollectionViewCell
            cell.setIndexPath(indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
}

extension BottomUpKeyboardHeightViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch viewModel.sections[indexPath.section] {
        case .inputText1, .inputText2:
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: 72
            )
        case .contents1, .contents2:
            return CGSize(
                width: UIScreen.main.bounds.width,
                height: 56
            )
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        .zero
    }
}

extension BottomUpKeyboardHeightViewController: TextFieldCollectionViewCellDelegate {
    func didBeginEditing(indexPath: IndexPath) {
        collectionView.scrollToItem(
            at: indexPath,
            at: .bottom,
            animated: false
        )
    }
    
    func didTapReturn() {
        view.endEditing(true)
    }
}

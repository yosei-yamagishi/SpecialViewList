import UIKit
import Combine

class SubtitlePlayerViewController: UIViewController {
    
    @IBOutlet weak var subtitlePlayerView: SubtitlePlayerView! {
        didSet {
            subtitlePlayerView.delegate = self
            subtitlePlayerView.updateContents(
                subtitleInfoList: viewModel.subtitleInfoList
            )
        }
    }
    @IBOutlet weak var playOrPauseButton: UIButton! {
        didSet {
            let action: UIAction = .init { [weak self] _ in
                self?.viewModel.playOrPause()
            }
            playOrPauseButton.addAction(action, for: .touchUpInside)
        }
    }
    
    private let viewModel: SubtitlePlayerViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(
        viewModel: SubtitlePlayerViewModel = SubtitlePlayerViewModel()
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
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.setupPlayer()
    }
    
    private func updatePlayOrPauseButton(isPlaying: Bool) {
        let systemName = isPlaying ? "pause.circle.fill" : "play.circle.fill"
        playOrPauseButton.setImage(
            UIImage(systemName: systemName),
            for: .normal
        )
    }
    
    private func bindViewModel() {
        viewModel.$activeScrollIndexPath
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] indexPath in
                guard let self = self else { return }
                    self.subtitlePlayerView.updateActivateIndex(indexPath:  indexPath)
                }
            )
            .store(in: &cancellables)
        
        viewModel.$subtitleInfoList
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] subtitleInfoList in
                guard let self = self else { return }
                    self.subtitlePlayerView.updateContents(subtitleInfoList: subtitleInfoList)
                }
            )
            .store(in: &cancellables)
        
        viewModel.$isPlaying
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isPlaying in
                guard let self = self else { return }
                    self.updatePlayOrPauseButton(isPlaying: isPlaying)
                }
            )
            .store(in: &cancellables)
    }
}

extension SubtitlePlayerViewController: SubtitlePlayerViewDelegate {
    func didTapSubtitle(subtitleInfo: SubtitleInfo) {
        viewModel.selectSubtitle(subtitleInfo: subtitleInfo)
    }
}

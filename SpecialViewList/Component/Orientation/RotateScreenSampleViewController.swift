import UIKit

class RotateScreenSampleViewController: UIViewController {

    @IBOutlet weak var screenView: UIView!
    @IBOutlet weak var fullScreenButton: UIButton! {
        didSet {
            fullScreenButton.addAction(
                rotateSreenViewAction(),
                for: .touchUpInside
            )
            fullScreenButton.setImage(
                UIImage(systemName: "arrow.up.left.and.arrow.down.right"),
                for: .normal
            )
        }
    }
    
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.setImage(
                UIImage(systemName: "xmark"),
                for: .normal
            )
            closeButton.addAction(
                closeAction(),
                for: .touchUpInside
            )
        }
    }
    
    private func closeAction() -> UIAction {
        UIAction { [weak self] _ in
            guard let self = self else { return }
            self.updateOrientaiton(deviceOrientation: .portrait)
            self.dismiss(animated: true)
        }
    }
    
    private func rotateSreenViewAction() -> UIAction {
        UIAction { [weak self] _ in
            guard let self = self else { return }
            let rotatedDeviceOrientation = self.isPortrait
                ? UIInterfaceOrientation.landscapeRight
                : UIInterfaceOrientation.portrait
            self.updateOrientaiton(
                deviceOrientation: rotatedDeviceOrientation
            )
            self.setScreenStateView(isPortrait: self.isPortrait)
        }
    }
    
    private func setScreenStateView(isPortrait: Bool) {
        let systemName = isPortrait
            ? "arrow.up.left.and.arrow.down.right"
            : "arrow.down.forward.and.arrow.up.backward"
        let iconImage = UIImage(systemName: systemName)
        fullScreenButton.setImage(
            iconImage,
            for: .normal
        )
    }
}

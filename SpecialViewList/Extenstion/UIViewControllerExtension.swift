import UIKit

extension UIViewController {
    var isPortrait: Bool { // 縦向き
        preferredInterfaceOrientationForPresentation.isPortrait
    }
    
    var isLandscape: Bool { // 横向き
        preferredInterfaceOrientationForPresentation.isLandscape
    }
    
    func updateOrientaiton(
        deviceOrientation: UIInterfaceOrientation
    ) {
        if #available(iOS 16.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene

            switch deviceOrientation {
            case .portrait:
                windowScene?.requestGeometryUpdate(
                    .iOS(interfaceOrientations: .portrait)
                )
            case .landscapeRight:
                windowScene?.requestGeometryUpdate(
                    .iOS(interfaceOrientations: .landscapeRight)
                )
            default: return
            }
            setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            UIDevice.setOrientation(
                deviceOrientation: deviceOrientation
            )
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
}

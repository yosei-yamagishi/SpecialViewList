import UIKit

extension UIDevice {
    static func setOrientation(
        deviceOrientation: UIDeviceOrientation
    ) {
        current.setValue(
            deviceOrientation.rawValue,
            forKey: "orientation"
        )
    }
}

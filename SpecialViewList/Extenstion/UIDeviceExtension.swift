import UIKit

extension UIDevice {
    static func setOrientation(
        deviceOrientation: UIInterfaceOrientation
    ) {
        current.setValue(
            deviceOrientation.rawValue,
            forKey: "orientation"
        )
    }
}

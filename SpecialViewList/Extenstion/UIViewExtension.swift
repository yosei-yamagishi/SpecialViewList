import UIKit

extension UIView {
    func maskCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func defaultMaskCorner() {
        maskCorner(radius: 6)
    }

    func allMaskCorner() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
}

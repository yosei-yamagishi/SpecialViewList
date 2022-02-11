import UIKit

public protocol NibOwnerLoadable: NibBundler {}

public extension NibOwnerLoadable where Self: UIView {
    func loadNibContent() {
        for case let view as UIView in Self.nib.instantiate(withOwner: self, options: nil) {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor),
                view.rightAnchor.constraint(equalTo: rightAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.leftAnchor.constraint(equalTo: leftAnchor)
            ])
        }
    }
}

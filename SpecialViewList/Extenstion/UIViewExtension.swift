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
    
    func border(
        borderWidth: CGFloat = 1,
        borderCGColor: CGColor
    ) {
        layer.borderColor = borderCGColor
        layer.borderWidth = borderWidth
    }
    
    func boarderWithMaskCorner(
        radius: CGFloat = 6,
        borderWidth: CGFloat = 1,
        borderCGColor: CGColor
    ) {
        border(
            borderWidth: borderWidth,
            borderCGColor: borderCGColor
        )
        maskCorner(radius: radius)
    }
}

extension UIView {
    func fadeIn(
        displayAlpha: CGFloat = 1.0,
        duration: TimeInterval = 0.3,
        completion: ((Bool) -> Void)? = nil
    ) {
        isHidden = false
        
        if alpha > .zero {
            alpha = .zero
        }
        
        UIView.animate(withDuration: duration, animations: { [weak self] in
            guard let self else { return }
            self.alpha = displayAlpha
        }, completion: { finished in
            completion?(finished)
        })
    }
    
    func fadeOut(
        duration: TimeInterval = 0.3,
        hideWhenDone: Bool = true,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: {  [weak self] finished in
            guard let self else { return }
            if hideWhenDone {
                self.isHidden = true
            }
            completion?(finished)
        })
    }
}

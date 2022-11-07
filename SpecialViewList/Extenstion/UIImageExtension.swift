import UIKit

extension UIImage {
    static func sfsymbolImage(sfsymbolType: SFSymbolType) -> UIImage? {
        UIImage(systemName: sfsymbolType.rawValue)
    }

    static func sfsymbolImage(
        sfsymbolType: SFSymbolType,
        pointSize: CGFloat
    ) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: pointSize)
        return UIImage(
            systemName: sfsymbolType.rawValue,
            withConfiguration: configuration
        )
    }
}

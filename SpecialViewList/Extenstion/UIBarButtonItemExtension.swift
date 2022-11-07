import UIKit

extension UIBarButtonItem {
    static func createCloseBarButtonItem(
        textColor: UIColor = .black,
        actionHandler: @escaping UIActionHandler
    ) -> UIBarButtonItem {
        let xmarkImage = UIImage.sfsymbolImage(
            sfsymbolType: .xmark,
            pointSize: 16
        )?.withRenderingMode(.alwaysTemplate)
        let barButtonItem = UIBarButtonItem(
            title: "",
            image: xmarkImage,
            primaryAction: UIAction(handler: actionHandler),
            menu: nil
        )
        barButtonItem.tintColor = textColor
        return barButtonItem
    }
}

import UIKit
import SwiftUI

class QuizAppByChatGPTViewController: UIHostingController<QuizTitleView> {
    
    init() {
        super.init(
            rootView: QuizTitleView()
        )
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

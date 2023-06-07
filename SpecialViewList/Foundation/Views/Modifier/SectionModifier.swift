import SwiftUI

struct SectionModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.white)
            .cornerRadius(4)
        
    }
}

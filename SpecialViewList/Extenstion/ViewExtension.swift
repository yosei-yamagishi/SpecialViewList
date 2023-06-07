import SwiftUI

extension View {
    var sectionStyle: some View {
        self.modifier(SectionModifier())
    }
}

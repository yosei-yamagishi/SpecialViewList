import SwiftUI

struct NextHostingBaseView: View {
    @ObservedObject private var viewModel: NextHostingControllerViewModel
    
    init(viewModel: NextHostingControllerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            VStack(spacing: 16) {
                Text("次の画面")
                Button {
                    viewModel.send(.dismissView)
                } label: {
                    Text("閉じる")
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct NextHostingBaseView_Previews: PreviewProvider {
    static var previews: some View {
        NextHostingBaseView(
            viewModel: NextHostingControllerViewModel()
        )
    }
}

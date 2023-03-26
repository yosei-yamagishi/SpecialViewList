import SwiftUI

struct HostingBaseView: View {
    
    @ObservedObject private var viewModel: HostingControllerViewModel
    
    init(viewModel: HostingControllerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            VStack(spacing: 16) {
                Text(viewModel.state.name)
                TextField("名前を入力してください。", text: $viewModel.state.name)
                    .padding()
                    .frame(height: 56)
                    .overlay(
                        RoundedRectangle(
                            cornerRadius: 16
                        ).stroke(.black, lineWidth: 1)
                    )
                Button {
                    viewModel.send(.didTapClearText)
                } label: {
                    Text("テキストをクリアする")
                }
                Button {
                    viewModel.send(.didTapOpenNextHostingBaseView)
                } label: {
                    Text("次の画面に遷移")
                }
            }.padding(.horizontal, 16)
        }
    }
}

struct HostingBaseView_Previews: PreviewProvider {
    static var previews: some View {
        HostingBaseView(viewModel: HostingControllerViewModel())
    }
}

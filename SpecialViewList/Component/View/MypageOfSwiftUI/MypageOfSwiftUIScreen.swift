import UIKit
import Combine
import SwiftUI

class MypageOfSwiftUIHostingController: UIHostingController<MypageOfSwiftUIScreen> {
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: MypageOfSwiftUIViewModel) {
        super.init(
            rootView: MypageOfSwiftUIScreen(
                viewModel: viewModel
            )
        )
        
        viewModel.$state.map(\.screenTransition)
            .compactMap { $0 }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] event in
                guard let self else { return }
                switch event.value {
                case .profile:
                    let viewModel = DummyViewModel(item: ItemContent(name: "プロフィール画面"))
                    let controller = DummyViewController(viewModel: viewModel)
                    self.navigationController?.pushViewController(
                        controller,
                        animated: true
                    )
                case .itemDetail(let item):
                    let viewModel = DummyViewModel(item: item)
                    let controller = DummyViewController(viewModel: viewModel)
                    self.navigationController?.pushViewController(
                        controller,
                        animated: true
                    )
                }
            })
            .store(in: &cancellables)
    }
    
    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "マイページ"
    }
}


struct MypageOfSwiftUIScreen: View {
    @ObservedObject private var viewModel: MypageOfSwiftUIViewModel
    
    init(viewModel: MypageOfSwiftUIViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray.ignoresSafeArea()
            ScrollView {
                VStack {
                    profileSection
                        .padding(16)
                    videoContentsSection
                        .padding(16)
                    itemListSection
                        .padding(.horizontal, 16)
                        .padding(.vertical, 0)
                }
            }
        }.onAppear {
            viewModel.send(.onAppearMainView)
        }
    }
    
    private var profileSection: some View {
        Button(action: {
            viewModel.send(.didTapProfile)
        }) {
            HStack(
                alignment: .center,
                spacing: 20
            ) {
                Circle()
                    .fill(.gray)
                    .frame(height: 64)
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text("MariaSharapowa")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Text("maria@gmail.jp")
                        .font(.system(size: 14))
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                chevronRightImage
            }
            .padding(16)
        }
        .buttonStyle(BorderlessButtonStyle())
        .sectionStyle
    }
    
    private var videoContentsSection: some View  {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                viewModel.send(.didTapSave)
            }) {
                itemCell(
                    title: "後で見る"
                )
            }
            .buttonStyle(BorderlessButtonStyle())
            Button(action: {
                viewModel.send(.didTapDownload)
            }) {
                itemCell(
                    title: "ダウンロード"
                )
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .sectionStyle
    }
    
    private var itemListSection: some View  {
        VStack(alignment: .leading, spacing: 8) {
            headerView(title: "アイテム一覧")
            VStack(spacing: 0) {
                ForEach(
                    viewModel.state.items.indices,
                    id: \.self
                ) { index in
                    Button(action: {
                        viewModel.send(.didTapItem(index: index))
                    }) {
                        itemCell(
                            title: viewModel.state.items[index].name
                        )
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    Divider()
                }
            }
        }
        .sectionStyle
    }
    
    private func headerView(title: String) -> some View {
        Text(title)
            .fontWeight(.bold)
            .font(Font.system(size: 16))
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .padding(16)
    }
    
    private func itemCell(title: String) -> some View  {
        HStack(spacing: 8) {
            Image(systemName: "bookmark")
                .foregroundColor(.gray)
                .frame(width: 22, height: 22)
            Text(title)
                .font(.system(size: 14))
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
            chevronRightImage
        }
        .padding(16)
    }
    
    private var chevronRightImage: some View  {
        Image(systemName: "chevron.right")
            .foregroundColor(.gray)
            .frame(width: 12.5, height: 16.5)
    }
}

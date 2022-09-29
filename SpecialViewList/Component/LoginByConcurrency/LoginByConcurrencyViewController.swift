import UIKit
import Combine

// 💡iOSDC2022の発表
// 「Swift Concurrency時代のiOSアプリの作り方」を参考に作ってみた
// https://speakerdeck.com/koher/swift-concurrencyshi-dai-noiosapurinozuo-rifang

@MainActor
class LoginByConcurrencyViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.allMaskCorner()
            loginButton.addAction(
                UIAction { [weak self] _ in
                    if #available(iOS 16.0, *) {
                        self?.login()
                    }
                },
                for: .touchUpInside
            )
        }
    }
    
    private let viewModel: LoginViewModel<AuthServiceImp>
    private var cancellables = Set<AnyCancellable>()
    
    init(
        viewModel: LoginViewModel<AuthServiceImp>
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    @available(*, unavailable)
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.$isLoginButtonEnabled.sink { [weak self] isEnabled in
            guard let self = self else { return }
            self.loginButton.isEnabled = isEnabled
        }
        .store(in: &cancellables)
    }
    
    @available(iOS 16.0, *)
    private func login() {
        // 💡Talk.initをVMではなくView側に書く
        // ※VMのテストが書きやすくなる
        // ※ただし、VMでキャンセルを扱いづらくなる
        Task {
            await viewModel.loginButtonPressed()
        }
    }
    
    // VCの直書きのlogin処理
    @available(iOS 16.0, *)
    private func loginByVC() {
        Task { // 💡同期メソッドから非同期処理を始めるにはTalk.initを使う
            loginButton.isEnabled = false
            
            defer {
                // 💡Swiftのバグ
                // @MainActorなメソッドでTalk.iniに渡すクロージャの中でdeferするとMainActorで保護されていないとハンダされてしまう
                // 2022/08/31に修正されてマージされている。今後のswift6などで
                // 💡MainActorで実行する方法
                // - await MainActor.run { }
                // Task { @MainActor in ... - }
                // 💡asyncメソッドから一部の処理をメインスレッドで実行したい場合は await MainActor.run {}
                // 💡同期メソッドからメインスレッドに処理を投げたい場合にはTask { @MainActor in }
                // 💡DspatchQueue.main.ayncは@Sendableがついていないので避けたほうがよい
                Task { @MainActor in
                    loginButton.isEnabled = true
                }
            }
            
            do { // 💡Talk.initにわたすクロージャーではdo/catchを忘れないようにする
//                let idToken = try await AuthAPI.login(
//                    id: .init(rawValue: self.idTextField.text ?? ""),
//                    password: self.passwordTextField.text ?? ""
//                )
                // 💡重めの処理はTask.detachedで別スレッドに逃がす
                // 💡Task.detached {} だとすり抜けてしまうので _ = try await Task.detached {} の形にする
                // 💡後続処理がある場合はTask.detachedからvalueを取得して処理が終わるのを待つ
                // 💡Task.detachedよりこの処理の部分をActorに切り出すほうが良いやり方
//                _ = try await Task.detached {
//                    if #available(iOS 16.0, *) {
//                        let data: Data = idToken.rawValue.data(using: .utf8)!
//                        let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
//                        try data.write(to: url, options: .atomic)
//                    }
//                }.value
                
                
                // 💡actorのメソッドは外から見ると非同期処理になる(asyncになる)
                // try await IDTokenStore.shared.update(idToken: idToken)
                try await AuthServiceImp.shared.login(
                    id: .init(rawValue: self.idTextField.text ?? ""),
                    password: self.passwordTextField.text ?? ""
                )
            } catch {
                // エラーハンドリング
            }
        }
    }
}

// 💡Sendableとは
// 並行に扱っても安全な型であることを示す
// - actor境界を超えるのに必要
// - Task.initなど@Sendableクロージャにキャプチャするのに必要
// ※すべてのプロパティをSendableにする必要がある
// 💡ポイント
// - 並行に扱う型はSendableに準拠させる
// - Sendable対応していない型は@unchecked Sendableで無理やり準拠させられる(安全な場合のみ)
//  → Xcode13までの場合は Dateは extension Date: @unchecked Sendable {} にしないといけない

struct User: Identifiable, Sendable {
    let id: ID
    var nickname: String
    var birthday: Date
    
    struct ID: Hashable, Sendable {
        let rawValue: String
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

struct IDToken: Sendable {
    let rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
}

enum AuthAPI  {
    static func login(
        id: User.ID,
        password: String
    ) async throws -> IDToken {
        let url = URL(string: "")!
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let idToken = IDToken(rawValue: "")
        return idToken
    }
}

// 💡actorはSwift5.5から導入された、データ競合を守るための新しい型
//   > データ競合は、２つのスレッドからアクセス（１つ以上の書き込みを含む）することで起きる。
//   > これをいかに防ぐかが並行処理プログラミングにおいて重要である。
//   https://zenn.dev/usk2000/articles/e8a8b42b7d1536
// 💡排他的に実行したい処理はActorで保護
// 💡actorはインスタンスごとにSerial Executorを持ち保護される
//  → グローバルに保護したいならシングルトンにする
// 💡Actorにすることでreadとwriteが同時におこなわれなくなり、actorをシングルトンにしておくとidなどは保護できる
actor IDTokenStore {
    static let shared: IDTokenStore = IDTokenStore()
    
    private init() {}
    
    @available(iOS 16.0, *)
    var value: IDToken {
        get throws {
            let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
            let data: Data = try .init(contentsOf: url)
            let rawValue: String = .init(data: data, encoding: .utf8)!
            return IDToken(rawValue: rawValue)
        }
    }
    
    @available(iOS 16.0, *)
    func update(idToken: IDToken) throws {
        let data: Data = idToken.rawValue.data(using: .utf8)!
        let url: URL = .libraryDirectory.appendingPathComponent("IDToken")
        try data.write(to: url, options: .atomic)
    }
}

protocol AuthService {
    static var shared: Self { get }
    @available(iOS 16.0, *)
    func login(
        id: User.ID,
        password: String
    ) async throws
}

actor AuthServiceImp: AuthService {
    static let shared = AuthServiceImp()
    
    private init() {}
    
    private var isLoggingIn: Bool = false
    
    @available(iOS 16.0, *)
    func login(
        id: User.ID,
        password: String
    ) async throws {
        if isLoggingIn {
            // ログイン中は弾く
        }
        isLoggingIn = true
        defer { isLoggingIn = false }
        let idToken = try await AuthAPI.login(id: id, password: password)
        try await IDTokenStore.shared.update(idToken: idToken)
    }
}

// 💡MainActorで保護することでUIの反映をメインスレッドで行える
@MainActor
final class LoginViewModel<AuthServiceImp>: ObservableObject where AuthServiceImp: AuthService {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoginButtonEnabled: Bool = true
    
    @available(iOS 16.0, *)
    func loginButtonPressed() async {
        isLoginButtonEnabled = false
        defer { isLoginButtonEnabled = true }
        
        do {
            try await AuthServiceImp.shared.login(
                id: .init(rawValue: id),
                password: password
            )
        } catch {
            // エラーハンドリング
        }
    }
}


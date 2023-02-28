enum SpecialViewList {
    enum Section: CaseIterable {
        case customView, viewController
        
        var title: String {
            switch self {
            case .viewController: return "ViewController"
            case .customView: return "CustomView"
            }
        }
        
        var items: [Item] {
            switch self {
            case .customView:
                return [
                    .grid3x3,
                    .autoFlowedTitle,
                    .linkLabel,
                    .subtitlePlayer,
                    .videoCollection,
                    .choiceForm,
                    .tableViewCellAnimation,
                    .defaultAVPlayerView,
                    .orientation
                ]
            case .viewController:
                return [
                    .hostingController,
                    .loginByConcurrency,
                    .videoPreviewOnCollectionView,
                    .bottomUpKeyboardHeightView,
                    .queuePlayerView
                ]
            }
        }
    }

    enum Item: CaseIterable {
        // customView
        case grid3x3, autoFlowedTitle, linkLabel, subtitlePlayer, videoCollection, choiceForm, tableViewCellAnimation, defaultAVPlayerView, orientation
        // viewController
        case hostingController, loginByConcurrency, videoPreviewOnCollectionView, bottomUpKeyboardHeightView, queuePlayerView
        
        var title: String {
            switch self {
            case .grid3x3:
                return "3行x3列のアイテムView"
            case .autoFlowedTitle:
                return "自動で流れるタイトルView"
            case .linkLabel:
                return "リンクできるラベルを含む警告View"
            case .subtitlePlayer:
                return "音声字幕が表示されるView"
            case .videoCollection:
                return "フリックで複数の動画が見れるView"
            case .choiceForm:
                return "選択肢を入力するフォーム"
            case .tableViewCellAnimation:
                return "TableVeiewのcellがアニメーションするView"
            case .defaultAVPlayerView:
                return "動画が自動で再生されるview"
            case .orientation:
                return "回転に対応するView"
            case .hostingController:
                return "SwiftUIのViewをUIKitのBaseのVCに表示する画面"
            case .loginByConcurrency:
                return "SwiftConcurrencyを利用したログイン画面"
            case .videoPreviewOnCollectionView:
                return "CollectionViewのCell上で動画を再生される画面"
            case .bottomUpKeyboardHeightView:
                return "入力時のキーボード高さ分の調整画面"
            case .queuePlayerView:
                return "AVQueuePlayerを用いた動画プレイヤー画面"
            }
        }
        
        var discription: String {
            switch self {
            case .grid3x3:
                return "3行x3列でアイテムを表示するViewです。\n"
                + "Labelに応じて可変に横幅が調整されます。"
            case .autoFlowedTitle:
                return "長いタイトルが自動で右から左、左から右に流れるView"
            case .linkLabel:
                return "タップ可能な下線付きラベルを含むView"
            case .subtitlePlayer:
                return "音声再生中に音声字幕が再生されている箇所に動くView"
            case .videoCollection:
                return "複数の動画を表示して再生するView"
            case .choiceForm:
                return "選択肢を4つまで増やして入力ができるフォームView"
            case .tableViewCellAnimation:
                return "TableVeiewのcellをタップすると別のcellが開くようなアニメーションするTableView"
            case .defaultAVPlayerView:
                return "AVKitのAVPlayerViewControllerを使用した方法で動画を再生するView"
            case .orientation:
                return "回転したときのViewの動きを確認するためView"
            case .hostingController:
                return "UIHostingViewControllerを使用して、SwiftUIのViewをUIKitのVCに表示するための画面"
            case .loginByConcurrency:
                return "MVVMのアーキテクチャでログイン画面を作成し、ログイン処理をSwiftConcurrencyを用いて記述している画面"
            case .videoPreviewOnCollectionView:
                return "CollectionViewのCell上で動画が正しく再生されるかやcellのreloadでも再生され続けるのかの確認の為の画面"
            case .bottomUpKeyboardHeightView:
                return "CollectionViewのCellに入力部分があり入力時にキーボードの高さ分だけ、ボトムの制約を調整してキーボードに隠れないようにして、入力しやすくする画面"
            case .queuePlayerView:
                return "AVQueuePlayerを使用して、複数の動画のリストから動画を選択して再生し、終わったら次の動画を再生する動画の再生プレイヤー画面"
            }
        }
    }
}

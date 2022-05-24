enum SpecialViewList {
    enum Section: CaseIterable {
        case customView
        
        var title: String {
            switch self {
            case .customView: return "CustomView"
            }
        }
        
        var items: [Item] {
            switch self {
            case .customView:
                return [.grid3x3, .autoFlowedTitle, .linkLabel, .subtitlePlayer]
            }
        }
    }

    enum Item: CaseIterable {
        case grid3x3, autoFlowedTitle, linkLabel, subtitlePlayer
        
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
            }
        }
    }
}

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
                return [.grid3x3, .autoFlowedTitle]
            }
        }
    }

    enum Item: CaseIterable {
        case grid3x3, autoFlowedTitle
        
        var title: String {
            switch self {
            case .grid3x3:
                return "3行x3列のアイテムView"
            case .autoFlowedTitle:
                return "自動で流れるタイトルView"
            }
        }
        
        var discription: String {
            switch self {
            case .grid3x3:
                return "3行x3列でアイテムを表示するViewです。\n"
                + "Labelに応じて可変に横幅が調整されます。"
            case .autoFlowedTitle:
                return "長いタイトルが自動で右から左、左から右に流れるView"
            }
        }
    }
}

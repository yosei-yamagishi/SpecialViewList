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
                return [.grid3x3]
            }
        }
    }

    enum Item: CaseIterable {
        case grid3x3
        
        var title: String {
            switch self {
            case .grid3x3:
                return "3行x3列のアイテムを表示するView"
            }
        }
        
        var discription: String {
            switch self {
            case .grid3x3:
                return "3行x3列でアイテムを表示するViewです。\n"
                + "Labelに応じて可変に横幅が調整されます。"
            }
        }
    }
}

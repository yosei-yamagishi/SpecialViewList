class TableViewCellAnimationViewModel {
    enum TableSection: CaseIterable {
        case section1
        case section2
        case section3
    }
    
    var sections: [TableSection] = TableSection.allCases
    
    var section1Titles: [String] = []
    var section2Titles: [String] = []
    var section3Titles: [String] = []
    
    func updateTitles(section: Int) {
        switch sections[section] {
        case .section1:
            section1Titles = section1Titles.isEmpty
                ? ["section1Title1"]
                : []
        case .section2:
            section2Titles = section2Titles.isEmpty
                ? ["section2Title1", "section2Title2"]
                : []
        case .section3:
            section3Titles = section3Titles.isEmpty
                ? ["section3Title", "section3Title2", "section3Title3"]
                : []
        }
    }
    
    func isHiddenContents(section: Int) -> Bool {
        switch sections[section] {
        case .section1: return section1Titles.isEmpty
        case .section2: return section2Titles.isEmpty
        case .section3: return section3Titles.isEmpty
        }
    }
}

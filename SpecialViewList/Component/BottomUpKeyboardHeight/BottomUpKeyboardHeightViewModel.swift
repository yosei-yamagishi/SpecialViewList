class BottomUpKeyboardHeightViewModel {
    enum SectionType: CaseIterable {
        case contents
        case input
    }
    
    let sections: [SectionType] = SectionType.allCases
    private(set) var contents: [ItemContent] = ItemContent.listContents
}

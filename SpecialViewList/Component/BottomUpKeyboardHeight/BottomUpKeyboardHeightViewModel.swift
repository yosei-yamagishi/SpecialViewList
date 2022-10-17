class BottomUpKeyboardHeightViewModel {
    enum SectionType: CaseIterable {
        case contents1
        case inputText1
        case contents2
        case inputText2
    }
    
    let sections: [SectionType] = SectionType.allCases
    private(set) var contents: [ItemContent] = ItemContent.listContents
}

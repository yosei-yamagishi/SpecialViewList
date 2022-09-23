protocol StateHolder: AnyObject {
    associatedtype State: Equatable

    var state: State { get }
}

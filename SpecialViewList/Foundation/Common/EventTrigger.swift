import Foundation

private protocol EventTriggerProtocol: Equatable {
    var identifier: String { get }
}

struct EventTrigger: EventTriggerProtocol {
    let identifier: String = UUID().uuidString

    static func == (lhs: EventTrigger, rhs: EventTrigger) -> Bool {
        lhs.identifier == rhs.identifier
    }
}

struct ValueEventTrigger<T>: EventTriggerProtocol {
    let identifier: String = UUID().uuidString
    let value: T

    static func == (lhs: ValueEventTrigger, rhs: ValueEventTrigger) -> Bool {
        lhs.identifier == rhs.identifier
    }

    init(value: T) {
        self.value = value
    }
}

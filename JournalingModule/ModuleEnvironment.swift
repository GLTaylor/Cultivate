import Foundation

// FOR LATER - can use this with some sort of remotely located questions provider, that needs to be loaded and such.

public struct ModuleEnvironment {
    var dateProvider: () -> Date
    var uuid: () -> UUID

    public static let live = ModuleEnvironment(
        dateProvider: Date.init,
        uuid: UUID.init
    )
}
#if DEBUG
extension ModuleEnvironment {
    static let fakeUUID = UUID()
    public static let mock = ModuleEnvironment(
        dateProvider: { Date.init(timeIntervalSince1970: 10)},
        uuid: { .fakeUUID }
    )
}
#endif

#if DEBUG
public extension UUID {
    static let fakeUUID = UUID()
}
#endif

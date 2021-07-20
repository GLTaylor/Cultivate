import Foundation
import SavingServiceKit
// FOR LATER - can use this with some sort of remotely located questions provider, that needs to be loaded and such.
// NOW - Not for loading but for saving. Do I need the date + id providers here?

public struct ModuleEnvironment {
    var persistenceDataProvider: DataProvider
    var dateProvider: () -> Date
    var uuid: () -> UUID

    public static let live = ModuleEnvironment(
        persistenceDataProvider: .live,
        dateProvider: Date.init,
        uuid: UUID.init
    )
}
#if DEBUG
extension ModuleEnvironment {
    static let fakeUUID = UUID()
    public static let mock = ModuleEnvironment(
//        fileManagerSaver: MyFileManager.fake,
        persistenceDataProvider: .live,
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

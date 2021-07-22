import Foundation
import SavingServiceKit

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

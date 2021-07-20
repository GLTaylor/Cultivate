import Foundation
import SavingServiceKit

public struct ModuleEnvironment {
    var persistenceDataProvider: DataProvider

    public static let live = ModuleEnvironment(
        persistenceDataProvider: .live
    )
}
#if DEBUG
extension ModuleEnvironment {
    public static let mock = ModuleEnvironment(
        // later mock
        persistenceDataProvider: .live
    )
}
#endif

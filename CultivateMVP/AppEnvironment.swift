import JournalingModule
import EntryHistoryModule
import SavingServiceKit

struct AppEnvironment {
    var journalModuleEnv: JournalingModule.ModuleEnvironment
    var entryHistoryModuleEnv: EntryHistoryModule.ModuleEnvironment
    var persistenceDataProvider: DataProvider

    // fix the module envs later
    static let live = AppEnvironment(journalModuleEnv: .live,
                                     entryHistoryModuleEnv: .live,
                                     persistenceDataProvider: .live)
}

#if DEBUG

extension AppEnvironment {
    static let mock = AppEnvironment(journalModuleEnv: .mock,
                                     entryHistoryModuleEnv: .mock,
                                     persistenceDataProvider: .mock)
}

#endif

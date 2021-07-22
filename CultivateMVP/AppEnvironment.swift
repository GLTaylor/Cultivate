import JournalingModule
import EntryHistoryModule
import HistoryLoader
import SavingServiceKit

struct AppEnvironment {
    var journalModuleEnv: JournalingModule.ModuleEnvironment
    var entryHistoryModuleEnv: EntryHistoryModule.ModuleEnvironment
    var historyLoaderModuleEnv: HistoryLoader.ModuleEnvironment
    var persistenceDataProvider: DataProvider

    // fix the module envs later
    static let live = AppEnvironment(journalModuleEnv: .live,
                                     entryHistoryModuleEnv: .live,
                                     historyLoaderModuleEnv: .live,
                                     persistenceDataProvider: .live)
}

#if DEBUG

extension AppEnvironment {
    static let mock = AppEnvironment(journalModuleEnv: .mock,
                                     entryHistoryModuleEnv: .mock,
                                     historyLoaderModuleEnv: .mock,
                                     persistenceDataProvider: .mock)
}

#endif

import BedrockModels
import JournalingModule
import EntryHistoryModule
import HistoryLoader
import ComposableArchitecture
import SavingServiceKit

typealias AppStore = Store<AppState, AppAction>

struct AppState: Equatable {
    var questionsAnswers = JournalQuestionsAnswers.defaultQuestionsAnswers
    var entryRoundNumber = 0
    var journalingHasStarted = false
    var entryHistory = EntryHistory.empty

    var journalModuleState: JournalingModule.ModuleState {
        get {
            JournalingModule.ModuleState.init(
                questionsAnswers: questionsAnswers,
                entryRoundNumber: entryRoundNumber,
                journalingHasStarted: journalingHasStarted,
                entryHistory: entryHistory)
        }

        set {
            questionsAnswers = newValue.questionsAnswers
            entryRoundNumber = newValue.entryRoundNumber
            journalingHasStarted = newValue.journalingHasStarted
            entryHistory = newValue.entryHistory

        }
    }

    var entryHistoryModuleState: EntryHistoryModule.ModuleState {
        get {
            EntryHistoryModule.ModuleState(entryHistory: entryHistory)
        }
        set {
            entryHistory = newValue.entryHistory
        }
    }

    var historyLoaderModuleState: HistoryLoader.ModuleState {
        get {
            HistoryLoader.ModuleState(entryHistory: entryHistory)
        }
        set {
            entryHistory = newValue.entryHistory
        }
    }

}

enum AppAction {
    case entryHistoryModule(EntryHistoryModule.ModuleAction)
    case journalingModule(JournalingModule.ModuleAction)
    case historyLoaderModule(HistoryLoader.ModuleAction)
}

let reducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    // key paths and case paths 
    JournalingModule.reducer.pullback(state: \.journalModuleState,
                                      action: /AppAction.journalingModule,
                                      environment: { $0.journalModuleEnv }),
    EntryHistoryModule.reducer.pullback(state: \.entryHistoryModuleState,
                                        action: /AppAction.entryHistoryModule,
                                        environment: { $0.entryHistoryModuleEnv }),
    HistoryLoader.reducer.pullback(state: \.historyLoaderModuleState,
                                   action: /AppAction.historyLoaderModule,
                                   environment: { $0.historyLoaderModuleEnv })
)

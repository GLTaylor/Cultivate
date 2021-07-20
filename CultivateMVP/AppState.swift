import BedrockModels
import JournalingModule
import EntryHistoryModule
import ComposableArchitecture
import SavingServiceKit

typealias AppStore = Store<AppState, AppAction>

struct AppState: Equatable {
    var mainQuestionAnswers = JournalQuestionsAnswers.defaultQuestionsAnswers
    var answeredQuestionAnswers: [JournalQuestionAnswer] = []
    var entryRoundNumber = 0
    var journalingHasStarted = false
    var entryHistory = EntryHistory.empty
    // entry history here is shared, I think. Maybe we should make it read from file manager instead of being empty at the beginning.

    var journalModuleState: JournalingModule.ModuleState {
        get {
            JournalingModule.ModuleState.init(
                mainQuestionAnswers: mainQuestionAnswers,
                answeredQuestionAnswers: answeredQuestionAnswers,
                entryRoundNumber: entryRoundNumber,
                journalingHasStarted: journalingHasStarted,
                entryHistory: entryHistory)
        }

        set {
            mainQuestionAnswers = newValue.mainQuestionAnswers
            answeredQuestionAnswers = newValue.answeredQuestionAnswers
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

}

enum AppAction {
    case entryHistoryModule(EntryHistoryModule.ModuleAction)
    case journalingModule(JournalingModule.ModuleAction)
    case loadEntryHistory
}

// add an environment that is the same for both?
// the env could maybe have two module envs in it? so not everything can be accessed outsideit?
// in the env.journalingModEnv we have access to env.database and one function which is to save
// in the env.entryHistoryModEnv we have the same access but just a load func?

let reducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    // must study these key paths and case paths, really cool
    JournalingModule.reducer.pullback(state: \.journalModuleState,
                                      action: /AppAction.journalingModule,
                                      environment: { $0.journalModuleEnv }),
    EntryHistoryModule.reducer.pullback(state: \.entryHistoryModuleState,
                                        action: /AppAction.entryHistoryModule,
                                        environment: { $0.entryHistoryModuleEnv }),
    loadHistoryReducer
)

let loadHistoryReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, env in
    switch action {
    case .entryHistoryModule(_):
        break
    case .journalingModule(_):
        break
    case .loadEntryHistory:
        state.entryHistory = .init(
            activities: (try? env.persistenceDataProvider
                .getAllData()
                .map(EntryHistory.Activity.init)) ?? []
        )
    }
    return .none
}

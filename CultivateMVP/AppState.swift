import BedrockModels
import JournalingModule
import EntryHistoryModule
import ComposableArchitecture

typealias AppStore = Store<AppState, AppAction>

struct AppState {
    var mainQuestionAnswers = JournalQuestionsAnswers.defaultQuestionsAnswers
    var answeredQuestionAnswers: [JournalQuestionAnswer] = []
    var entryRoundNumber = 0
    var journalingHasStarted = false
    var entryHistory = EntryHistory.empty

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
}

let reducer = Reducer<AppState, AppAction, Void>.combine(
    // must study these key paths and case paths, really cool
    JournalingModule.reducer.pullback(state: \.journalModuleState,
                                      action: /AppAction.journalingModule,
                                      environment: { _ in }),
    EntryHistoryModule.reducer.pullback(state: \.entryHistoryModuleState,
                                        action: /AppAction.entryHistoryModule,
                                        environment: { _ in })
)

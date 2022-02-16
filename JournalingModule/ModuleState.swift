import Foundation
import BedrockModels
import ComposableArchitecture
import SavingServiceKit

public typealias ModuleStore = Store<ModuleState, ModuleAction>
public typealias ModuleEffect = Effect<ModuleAction, Never>

public struct ModuleState: Equatable {
    public var questionsAnswers: JournalQuestionsAnswers
    public var entryRoundNumber: Int
    public var journalingHasStarted: Bool
    // could make history optional to not have to make it empty?
    public var entryHistory: EntryHistory

    public init(questionsAnswers: JournalQuestionsAnswers = .defaultQuestionsAnswers,
                entryRoundNumber: Int = 0,
                journalingHasStarted: Bool = false,
                entryHistory: EntryHistory = .empty
    ) {
        self.questionsAnswers = questionsAnswers
        self.entryRoundNumber = entryRoundNumber
        self.journalingHasStarted = journalingHasStarted
        self.entryHistory = entryHistory
    }
}

public enum ModuleAction: Equatable {
    case forward
    case startJournaling
    case stopJournaling
    case back
    case answerChanged(JournalQuestionAnswer.Answer)
}

public let reducer = Reducer<ModuleState, ModuleAction, ModuleEnvironment> { state, action, env  in
    switch action {
    case .forward:
        if state.entryRoundNumber >= state.questionsAnswers.questionsAnswers.count - 1 {
            state.journalingHasStarted = false
            state.entryHistory.activities.insert(.init(id: UUID(),
                                                       timestamp: Date(),
                                                       resultSet: state.questionsAnswers.questionsAnswers),
                                                 at: 0)
            try? env.persistenceDataProvider.saveData(
                state.entryHistory.activities.map(SavableActivity.init)
            )
        } else {
            state.entryRoundNumber += 1
        }
    case .startJournaling:
        state.entryRoundNumber = 0
        state.journalingHasStarted = true
        // eventually could return effect here, load questions from somewhere
    case .stopJournaling:
        state.journalingHasStarted = false
    case .back:
        if state.entryRoundNumber >= 1 {
            state.entryRoundNumber -= 1
    }
    case .answerChanged(let answer):
        state.questionsAnswers.questionsAnswers[state.entryRoundNumber].answer = answer
    }

    return .none
}

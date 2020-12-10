import Foundation
import BedrockModels
import ComposableArchitecture

public typealias ModuleStore = Store<ModuleState, ModuleAction>
public typealias ModuleEffect = Effect<ModuleAction, Never>

public struct ModuleState: Equatable {
    public var mainQuestionAnswers: JournalQuestionsAnswers
    public var answeredQuestionAnswers: [JournalQuestionAnswer]
    public var entryRoundNumber: Int
    public var journalingHasStarted: Bool
    public var entryHistory: EntryHistory

    public init(mainQuestionAnswers: JournalQuestionsAnswers = .defaultQuestionsAnswers,
                answeredQuestionAnswers: [JournalQuestionAnswer] = [],
                entryRoundNumber: Int = 0,
                journalingHasStarted: Bool = false,
                entryHistory: EntryHistory = .empty
    ) {
        self.mainQuestionAnswers = mainQuestionAnswers
        self.answeredQuestionAnswers = answeredQuestionAnswers
        self.entryRoundNumber = entryRoundNumber
        self.journalingHasStarted = journalingHasStarted
        self.entryHistory = entryHistory
    }
}

public enum ModuleAction: Equatable {
    case answer(enteredAnswer: JournalQuestionAnswer.Answer)
    case startJournaling
    case stopJournaling
}

public let reducer = Reducer<ModuleState, ModuleAction, Void> { state, action, _  in
    // nothing with environment yet, will replace Void later w ModuleEnvironment
    switch action {
    case .answer(let answer):
        let question = state.mainQuestionAnswers.questionsAnswers[state.entryRoundNumber].question
        switch answer {
        case .slider(let number):
            state.answeredQuestionAnswers.append(.init(question: question, answer: .slider(number)))
        case .text(let text):
            state.answeredQuestionAnswers.append(.init(question: question, answer: .text(text)))
        }
        if state.entryRoundNumber >= state.mainQuestionAnswers.questionsAnswers.count - 1 {
            state.journalingHasStarted = false
            state.entryHistory.activities.insert(.init(id: UUID(),
                                                       timestamp: Date(),
                                                       resultSet: state.answeredQuestionAnswers),
                                                 at: 0)
        } else {
            state.entryRoundNumber += 1
        }
    case .startJournaling:
        state.entryRoundNumber = 0
        state.answeredQuestionAnswers = []
        state.journalingHasStarted = true
        // eventually could return effect here, load questions from somewhere
    case .stopJournaling:
        state.journalingHasStarted = false
    }

    return .none
}

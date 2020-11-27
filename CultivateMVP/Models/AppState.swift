import Foundation

struct AppState {
    var mainQuestionAnswers = JournalQuestionsAnswers.defaultQuestionsAnswers
    var answeredQuestionAnswers: [JournalQuestionAnswer] = []
    var entryRoundNumber = 0
    var journalingHasStarted = false
    var entryHistory = EntryHistory.empty

}

enum AppAction {
    case answer(enteredAnswer: JournalQuestionAnswer.Answer)
    case startJournaling
    case stopJournaling
}

func reducer(state: inout AppState, action: AppAction) -> Effect<AppAction>? {
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
        // remove entries, tbd later
    }

    return nil
}

typealias AppStore = Store<AppState, AppAction>

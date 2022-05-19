import XCTest
@testable import JournalingModule
import Combine
import ComposableArchitecture
import BedrockModels

class JournalingModuleTests: XCTestCase {

    var environment: ModuleEnvironment!

    override func setUp() {
        super.setUp()
        environment = .mock
    }

    func testMainJournalScenario() {
        let testDate = Date(timeIntervalSince1970: 5)

        environment.dateProvider = { testDate }

        let fakeModuleState = ModuleState(
            questionsAnswers: .fakeQuestionsAnswers,
            entryRoundNumber: 0,
            journalingHasStarted: false,
            entryHistory: .empty
        )

        let testStore = TestStore(initialState: fakeModuleState, reducer: reducer, environment: environment)

        testStore.assert(
            .send(.startJournaling) {
                $0.entryHistory = .empty
                $0.journalingHasStarted = true
                $0.entryRoundNumber = 0
                $0.questionsAnswers = .fakeQuestionsAnswers
            },
            .send(.answerChanged(.slider(4))) {
                $0.questionsAnswers = .init(questionsAnswers: [
                    .init(id: .fakeUUID,
                          question: "How do you feel?",
                          answer: .slider(4)),
                    .init(id: .fakeUUID,
                          question: "Who was a friend today?",
                          answer: .text("")),
                    .init(id: .fakeUUID,
                          question: "What would you like the final answer to be?",
                          answer: .text(""))
                ])
                $0.entryRoundNumber = 0
                $0.journalingHasStarted = true
            },
            .send(.forward) {
                $0.questionsAnswers = .init(questionsAnswers: [
                    .init(id: .fakeUUID,
                          question: "How do you feel?",
                          answer: .slider(4)),
                    .init(id: .fakeUUID,
                          question: "Who was a friend today?",
                          answer: .text("")),
                    .init(id: .fakeUUID,
                          question: "What would you like the final answer to be?",
                          answer: .text(""))
                ])
                $0.entryRoundNumber = 1
                $0.journalingHasStarted = true
            },
            .send(.answerChanged(.text("Text"))) {
                $0.questionsAnswers = .init(questionsAnswers: [
                    .init(id: .fakeUUID,
                          question: "How do you feel?",
                          answer: .slider(4)),
                    .init(id: .fakeUUID,
                          question: "Who was a friend today?",
                          answer: .text("Text")),
                    .init(id: .fakeUUID,
                          question: "What would you like the final answer to be?",
                          answer: .text(""))
                ])
                $0.entryRoundNumber = 1
                $0.journalingHasStarted = true
            }
        )
    }

}

public extension JournalQuestionsAnswers {
    static let fakeQuestionsAnswers = JournalQuestionsAnswers(questionsAnswers: [
        .init(id: .fakeUUID,
              question: "How do you feel?",
              answer: .slider(0)),
        .init(id: .fakeUUID,
              question: "Who was a friend today?",
              answer: .text("")),
        .init(id: .fakeUUID,
              question: "What would you like the final answer to be?",
              answer: .text(""))
    ])
}

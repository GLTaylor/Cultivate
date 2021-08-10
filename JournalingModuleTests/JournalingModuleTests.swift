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
            mainQuestionAnswers: .fakeQuestionsAnswers,
            answeredQuestionAnswers: [],
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
                $0.answeredQuestionAnswers = []
            },
            .send(.answer(enteredAnswer: .slider(4))) {
                $0.answeredQuestionAnswers = [
                    JournalQuestionAnswer.init(
                        id: .fakeUUID,
                        question: "How do you feel?",
                        answer: .slider(4))
                ]
                $0.entryRoundNumber = 1
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
              answer: .text("Sarah"))
    ])
}

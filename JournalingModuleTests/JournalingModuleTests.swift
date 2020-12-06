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

        let testStore = TestStore(initialState: ModuleState(), reducer: reducer, environment: environment)

        testStore.assert(
            .send(.startJournaling) {
                $0.entryHistory = .empty
                $0.journalingHasStarted = true
                $0.entryRoundNumber = 0
                $0.answeredQuestionAnswers = []
            },
            .send(.answer(enteredAnswer: .slider(7))) {
                $0.answeredQuestionAnswers = [JournalQuestionAnswer.init(question: "How are you feeling today?", answer: .slider(7))]
                $0.entryRoundNumber = 1
            }
        )
    }

}


import XCTest
@testable import EntryHistoryModule
import ComposableArchitecture
import BedrockModels

class EntryHistoryModuleTests: XCTestCase {
    func testRemoveActivities() {
        let testStore = TestStore(
            initialState: ModuleState(entryHistory: EntryHistory.init(activities: [
                .init(id: .fakeUUID, timestamp: Date(timeIntervalSince1970: 0), resultSet: [
                    .init(id: .fakeUUID, question: "First question", answer: .text("First answer"))
                ]),
                .init(id: .fakeUUID, timestamp: Date(timeIntervalSince1970: 0), resultSet: [
                    .init(id: .fakeUUID, question: "Second question", answer: .text("Second Answer"))
                ])
            ])),
            reducer: reducer,
            environment: .mock
        )

        testStore.assert([
            .send(.removeEntries(indexSet: [0])) {
                $0.entryHistory = .init(activities: [
                    .init(id: .fakeUUID, timestamp: Date(timeIntervalSince1970: 0), resultSet: [
                        .init(id: .fakeUUID, question: "Second question", answer: .text("Second Answer"))
                    ])
                ])
            }
        ])
    }

}

#if DEBUG
extension UUID {
    static let fakeUUID = UUID()

}
#endif

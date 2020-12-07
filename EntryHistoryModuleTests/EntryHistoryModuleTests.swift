import XCTest
@testable import EntryHistoryModule
import ComposableArchitecture
import BedrockModels

class EntryHistoryModuleTests: XCTestCase {
    func testRemoveActivities() {
        let testStore = TestStore(
            initialState: ModuleState(entryHistory: EntryHistory.init(activities: [
                .init(id: .fakeUUID, timestamp: Date(timeIntervalSince1970: 0), resultSet: [])
            ])),
            reducer: reducer,
            environment: ()
        )

        testStore.assert([
            .send(.removeEntries(indexSet: [0])) {
                $0.entryHistory = .empty
            }
        ])
    }

}

#if DEBUG
extension UUID {
    static let fakeUUID = UUID()
}
#endif

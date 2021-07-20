import Foundation
import BedrockModels
import ComposableArchitecture
import SavingServiceKit

public typealias ModuleStore = Store<ModuleState, ModuleAction>
public typealias ModuleEffect = Effect<ModuleAction, Never>

public struct ModuleState: Equatable {
    public var entryHistory: EntryHistory

    public init(entryHistory: EntryHistory) {
        self.entryHistory = entryHistory
    }
}

public enum ModuleAction: Equatable {
    case removeEntries(indexSet: IndexSet)
}

public let reducer = Reducer<ModuleState, ModuleAction, ModuleEnvironment> { state, action, env in
    switch action {
    case .removeEntries(let indexSet):
        state.entryHistory.activities.remove(at: indexSet)
        try? env.persistenceDataProvider.saveData(
            state.entryHistory.activities.map(SavableActivity.init)
        )

    }
    return .none
}

private extension Array {
    mutating func remove(at indexes: IndexSet) {
        var enumerated = Swift.Array(self.enumerated())
        enumerated.removeAll { indexes.contains($0.offset) }
        self = enumerated.map { $0.element }
    }
}

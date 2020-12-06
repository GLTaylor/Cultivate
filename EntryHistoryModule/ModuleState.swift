import Foundation
import BedrockModels
import ComposableArchitecture

public typealias ModuleStore = Store<ModuleState, ModuleAction>
public typealias ModuleEffect = Effect<ModuleAction, Never>

public struct ModuleState: Equatable {
    var entryHistory = EntryHistory.empty
}

public enum ModuleAction {
    case removeEntries(indexSet: IndexSet)
}

public let reducer = Reducer<ModuleState, ModuleAction, Void> { state, action, _ in
    switch action {
    case .removeEntries(let indexSet):
        state.entryHistory.activities.remove(at: indexSet)
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

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
    case loadHistory
}

public let reducer = Reducer<ModuleState, ModuleAction, ModuleEnvironment> { state, action, env in
    switch action {
    case .loadHistory:
        state.entryHistory = .init(
            activities: (try? env.persistenceDataProvider
                .getAllData()
                .map(EntryHistory.Activity.init)) ?? []
        )
        return .none
    }
}

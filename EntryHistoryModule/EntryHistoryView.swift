import SwiftUI
import BedrockModels
import ComposableArchitecture

public struct EntryHistoryView: View {
   let store: ModuleStore

    public init(store: ModuleStore) {
        self.store = store
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    public var body: some View {
        WithViewStore(store) { viewStore in
        NavigationView {
                List {
                    ForEach(viewStore.state.entryHistory.activities) { activity in
                        VStack {
                            Text("Completed at: \(self.dateFormatter.string(from: activity.timestamp))")
                                .foregroundColor(.blue)
                            Text("Activty: \(activity.resultSet[1].question)")
                        }
                    .padding(5)
                    }
                    .onDelete { indexSet in
                        viewStore.send(.removeEntries(indexSet: indexSet))

                    }
                }
            .navigationBarTitle(Text("Log"))
            }
        }
    }
}

struct EntryHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        var state = ModuleState()
        state.entryHistory.activities = [
            .init(id: UUID(),
                  timestamp: Date(timeIntervalSinceNow: 10),
                  resultSet: [
                    .init(question: "How are you?", answer: .text("Great"))
                    ]
                  )
            ]

        return EntryHistoryView(store: ModuleStore(initialState: state, reducer: reducer, environment: ()))

    }

}

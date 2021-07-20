import SwiftUI
import BedrockModels
import ComposableArchitecture
import DesignKit

public struct EntryHistoryView: View {
    let store: ModuleStore

    public init(store: ModuleStore) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
                NavigationView {
                List {
                    ForEach(viewStore.state.entryHistory.activities) { activity in
                        NavigationLink(destination: SingleEntryView(activity: activity)) {
                            VStack {
                                Text("Cultivated: \(EntryDateFormatter.string(from: activity.timestamp))")
                                    .foregroundColor(Color(ColorNameManager.Green.forrest))
                                    .font(Font.custom(FontNameManager.Montserrat.medium, fixedSize: 20))
                                    .padding()
                                Text("Something you thought about: \(activity.resultSet.randomElement()!.question)")
                                    .font(Font.custom(FontNameManager.Montserrat.semiBold, fixedSize: 16))
                                    .multilineTextAlignment(.center)
                            }
                            .padding(5)
                        }
                    }
                    .onDelete { indexSet in
                        viewStore.send(.removeEntries(indexSet: indexSet))
                    }
                }
                .navigationBarTitle(Text("Your Entries"))
            }

        }
    }
}

struct EntryHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        var state = ModuleState(entryHistory: .empty)
        state.entryHistory.activities = [
            .init(id: UUID(),
                  timestamp: Date(timeIntervalSinceNow: 10),
                  resultSet: [
                    .init(question: "How are you doing with everything?", answer: .text("Great"))
                    ]
                  )
            ]

        return EntryHistoryView(store: ModuleStore(initialState: state, reducer: reducer, environment: .live))

    }

}

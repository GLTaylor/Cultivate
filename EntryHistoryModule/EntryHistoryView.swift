import SwiftUI
import ComposableArchitecture

struct EntryHistoryView: View {
   let store: ModuleStore

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    var body: some View {
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
        state.entryHistory.activities
        
    }

}


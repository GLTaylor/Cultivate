import SwiftUI

struct EntryHistoryView: View {

    @ObservedObject var store: AppStore

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(store.state.entryHistory.activities) { activity in
                    VStack {
                        Text("Completed at: \(self.dateFormatter.string(from: activity.timestamp))")
                            .foregroundColor(.blue)
                        Text("Activty: \(activity.resultSet[1].question)")
                    }
                .padding(5)
                }
//                .onDelete { indexSet in
//                    self.store.send(.removeActivities(indexSet: indexSet))
//
//                }
            }
        .navigationBarTitle(Text("Log"))
        }
    }
}

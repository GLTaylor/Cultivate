import SwiftUI
import JournalingModule
import EntryHistoryModule

struct TabBarView: View {
    let store: AppStore

    var body: some View {
        TabView {
            JournalStartView(store: store.scope(state: { $0.journalModuleState },
                                                action: { .journalingModule($0) }))
                .tabItem {
                    Image.home
                    .resizable()
                    .scaledToFit()
                    Text("Start")
                }
            EntryHistoryView(store: store.scope(state: { $0.entryHistoryModuleState },
                                                 action: { .entryHistoryModule($0) }))
            .tabItem {
                Image.log
                .resizable()
                .scaledToFit()
                Text("Log")
            }
        }
    }
}

private extension Image {
    static let home = Image("home")
    static let log = Image("log")
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(store: AppStore(initialState: AppState(), reducer: reducer, environment: .live))
    }
}

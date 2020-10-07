import SwiftUI

struct TabBarView: View {
    @ObservedObject var store: AppStore

    var body: some View {
        TabView {
            ThoughtOfDayView(store: store)
                .tabItem {
//                    Image.journal
                    Text("Game")
            }
            EntryHistoryView(store: store)
            .tabItem {
//                Image.log
                Text("Score")
            }
        }
    }
}

//private extension Image {
//    static let journal = Image(systemName: "gamecontroller.fill")
//    static let log = Image(systemName: "list.dash")
//}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(store: AppStore(initialState: AppState(), reducer: reducer))
    }
}

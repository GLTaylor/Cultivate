import SwiftUI

struct TabBarView: View {
    @ObservedObject var store: AppStore

    var body: some View {
        TabView {
            ThoughtOfDayView(store: store)
                .tabItem {
                    Image.home
                    .resizable()
                    .scaledToFit()
                    Text("Start")
            }
            EntryHistoryView(store: store)
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
        TabBarView(store: AppStore(initialState: AppState(), reducer: reducer))
    }
}

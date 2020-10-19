import SwiftUI

struct ThoughtOfDayView: View {
    @ObservedObject var store: AppStore

    let titleFont = Font.custom(FontNameManager.PTSerif.bold, size: 50)

    var body: some View {
        Button(action: { self.store.send(.startJournaling)},
               label: { Text("Let's begin to cultivate something great")})
            .font(titleFont)
            .accentColor(.black)
            .sheet(isPresented: Binding.constant(store.state.journalingHasStarted),
                   onDismiss: { self.store.send(.stopJournaling) },
                   content: { JournalingView(store: self.store) })
    }
}

    struct ThoughtOfDayView_Previews: PreviewProvider {
        static var previews: some View {
            return ThoughtOfDayView(store: AppStore(initialState: AppState(), reducer: reducer))
        }
    }

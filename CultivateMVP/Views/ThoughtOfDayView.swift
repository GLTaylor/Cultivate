import SwiftUI

struct ThoughtOfDayView: View {
    @ObservedObject var store: AppStore

    let titleFont = Font.custom(FontNameManager.PTSerif.bold, size: 40)
    let buttonFont = Font.custom(FontNameManager.Montserrat.semiBold, size: 20)

    var body: some View {
        VStack {
            Text("Let's begin to cultivate")
                .font(titleFont)
                .foregroundColor(Color("ForrestGreen"))
            Button(action: { self.store.send(.startJournaling)},
                   label: { Text("Start Journaling")})
                .padding()
                .foregroundColor(.white)
                .background(Color("ForrestGreen"))
                .cornerRadius(40)
                .font(buttonFont)
                .foregroundColor(Color("ForrestGreen"))
                .sheet(isPresented: Binding.constant(store.state.journalingHasStarted),
                       onDismiss: { self.store.send(.stopJournaling) },
                       content: { JournalingView(store: self.store) })
        }
    }
    // results
}

    struct ThoughtOfDayView_Previews: PreviewProvider {
        static var previews: some View {
            return ThoughtOfDayView(store: AppStore(initialState: AppState(), reducer: reducer))
        }
    }

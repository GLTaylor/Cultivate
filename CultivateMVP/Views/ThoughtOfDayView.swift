import SwiftUI

struct ThoughtOfDayView: View {
    @ObservedObject var store: AppStore

    let titleFont = Font.custom(FontNameManager.PTSerif.bold, size: 40)
    let buttonFont = Font.custom(FontNameManager.Montserrat.semiBold, size: 20)
    let pastEntryTitle = Font.custom(FontNameManager.Montserrat.italic, size: 20)
    let pastEntryText = Font.custom(FontNameManager.Montserrat.medium, size: 15)

    var body: some View {
        VStack {
            Text("Let's begin to cultivate")
                .font(titleFont)
                .foregroundColor(Color(ColorNameManager.Green.forrest))
                .padding(.bottom, 40)
            Button(action: { self.store.send(.startJournaling)},
                   label: { Text("Start Journaling")})
                .padding()
                .foregroundColor(.white)
                .background(Color(ColorNameManager.Green.forrest))
                .cornerRadius(40)
                .font(buttonFont)
                .foregroundColor(Color((ColorNameManager.Green.forrest)))
                .sheet(isPresented: Binding.constant(store.state.journalingHasStarted),
                       onDismiss: { self.store.send(.stopJournaling) },
                       content: { JournalingView(store: self.store) })

            latestEntry
                .padding(.top, 40)
        }
//       if latestEntry was here, it becomes a second tab (?!)
    }

// Bug for later: When skipping a question, text is actually "", not nil.
// Implementing a hacky workaround for now.
// Need to rewrite models and logic for answer to potentially be nil.

    private var latestEntry: AnyView {
        guard let entry = store.state.entryHistory.activities.first?.resultSet else {
            return AnyView(EmptyView())
        }
        var entryTextView: AnyView {
            switch entry.last(where: { ($0.answer != .text("")) })?.answer {
            case let .text(theString):
                if theString.count > 1 {
                    return AnyView(
                        Group {
                            VStack(spacing: 10) {
                                Text("Your last thought:")
                                    .font(pastEntryTitle)
                                Text("\"\(theString)\"")
                                    .font(pastEntryText)
                            }
                        }.padding()
                    )
                } else {
                    return AnyView(EmptyView())
                }
            case .slider, .none:
                return AnyView(EmptyView())
            }
        }
        return entryTextView
    }
}

    struct ThoughtOfDayView_Previews: PreviewProvider {
        static var previews: some View {
            var state = AppState()
            state.entryHistory.activities = [
                .init(id: UUID(),
                      timestamp: Date(timeIntervalSinceNow: 10),
                      resultSet: .init(arrayLiteral: .init(
                        question: "How you feelin",
                        answer: .text("Be good to mom, she's going thru a lot just like any human and you may not be able to totally comprehend exactly what it is"))))
            ]
            return ThoughtOfDayView(store: AppStore(initialState: state, reducer: reducer))
        }
    }

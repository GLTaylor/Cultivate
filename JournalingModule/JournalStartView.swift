import SwiftUI
import ComposableArchitecture
import DesignKit

public struct JournalStartView: View {
    let store: ModuleStore

    public init(store: ModuleStore) {
        self.store = store
    }

    let titleFont = Font.custom(FontNameManager.PTSerif.bold, size: 40)
    let buttonFont = Font.custom(FontNameManager.Montserrat.semiBold, size: 20)
    let pastEntryTitle = Font.custom(FontNameManager.Montserrat.italic, size: 20)
    let pastEntryText = Font.custom(FontNameManager.Montserrat.medium, size: 15)

    public var body: some View {
        WithViewStore(store) { viewStore in
            Color(ColorNameManager.Grey.cloud).edgesIgnoringSafeArea(.all).overlay(
                VStack {
                    Text("Let's begin to cultivate")
                        .font(titleFont)
                        .foregroundColor(Color(ColorNameManager.Green.forrest))
                        .padding(.bottom, 40)
                    Button(action: { viewStore.send(.startJournaling)},
                           label: { Text("Start Journaling")})
                        .padding()
                        .foregroundColor(.white)
                        .background(Color(ColorNameManager.Green.forrest))
                        .cornerRadius(40)
                        .font(buttonFont)
                        .foregroundColor(Color((ColorNameManager.Green.forrest)))
                        .sheet(isPresented: Binding.constant(viewStore.state.journalingHasStarted),
                               onDismiss: { viewStore.send(.stopJournaling) },
                               content: { JournalingView(store: self.store) })

                    latestEntry
                        .padding(.top, 40)
                }
            )
            //       if latestEntry was here, it becomes a second tab (?!)
        }
    }

    // Bug for later: When skipping a question, text is actually "", not nil.
    // Implementing a hacky workaround for now.
    // In the future I may rewrite models and logic for answer to potentially be nil.

    private var latestEntry: some View {
        WithViewStore(store) { viewStore -> AnyView in
            guard let entry = viewStore.state.entryHistory.activities.first?.resultSet else {
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
}

struct JournalStartView_Previews: PreviewProvider {
    static var previews: some View {
        var state = ModuleState()
        state.entryHistory.activities = [
            .init(id: UUID(),
                  timestamp: Date(timeIntervalSinceNow: 10),
                  resultSet: .init(arrayLiteral: .init(
                                    question: "How you feelin",
                                    answer: .text("Be good to mom, she's going thru a lot"))))
        ]
        return JournalStartView(store: ModuleStore(initialState: state, reducer: reducer, environment: .live))
    }
}

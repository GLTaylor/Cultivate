import SwiftUI
import ComposableArchitecture
import DesignKit

struct JournalingView: View {
    let store: ModuleStore

    var body: some View {
        WithViewStore(store) { viewStore in
            Color(ColorNameManager.Grey.cloud).edgesIgnoringSafeArea(.all).overlay(
                VStack(alignment: .leading) {
                    Button(action: { viewStore.send(.back) },
                           label: { Text("back")})
                    .font(Font.custom(FontNameManager.Montserrat.light, size: 20))
                    .accentColor(Color(ColorNameManager.Green.fern))
                    let roundNumber = viewStore.state.entryRoundNumber
                    let totalQuestions = viewStore.state.questionsAnswers.questionsAnswers.count - 1
                    Text("QUESTION \(roundNumber) / \(totalQuestions)")
                        .font(Font.custom(FontNameManager.Montserrat.regular, size: 15))
                        .foregroundColor(Color(ColorNameManager.Grey.ash))
                        .padding([.top, .bottom])
                    Text(viewStore.state.questionsAnswers.questionsAnswers[roundNumber].question)
                        .font(Font.custom(FontNameManager.Montserrat.regular, size: 25))
                        .foregroundColor(Color(ColorNameManager.Grey.ash))
                    switch viewStore.state.questionsAnswers.questionsAnswers[roundNumber].answer {
                    case .text(let text):
                        TextEditor(text: .init(
                            get: { text },
                            set: { viewStore.send(.answerChanged(.text($0)))
                        }))
                            .font(Font.custom(FontNameManager.Montserrat.light, size: 20))
                        Button(action: {
                            viewStore.send(.forward)
                        }, label: {
                            if roundNumber >= totalQuestions {
                                Text("Finish")
                            } else {
                                if text != "" {
                                    Text("Save")
                                } else {
                                    Text("Skip")
                                }
                            }
                        })
                        .font(Font.custom(FontNameManager.Montserrat.semiBold, size: 20))
                        .accentColor(Color(ColorNameManager.Green.forrest))

                    case .slider(let number):
                        Slider(value: .init(
                            get: { Double(number) },
                            set: { viewStore.send(
                                .answerChanged(.slider(Int($0)))
                            )}), in: 0...10, step: 1.0)
                            .accentColor(Color("ForrestGreen"))
                        Button(action: {
                            viewStore.send(.forward)
                        }, label: {
                            Text("Save \(Int(number))")
                                .font(Font.custom(FontNameManager.Montserrat.semiBold, size: 20))
                                .accentColor(Color("ForrestGreen"))
                        })
                    }
                }.padding()
            )
        }
    }
}

struct  JournalingView_Previews: PreviewProvider {
    static var previews: some View {
        JournalingView(store: ModuleStore(initialState: ModuleState(), reducer: reducer, environment: .live))
    }
}

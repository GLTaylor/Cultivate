import SwiftUI
import ComposableArchitecture
import DesignKit

struct JournalingView: View {
    let store: ModuleStore
    @State var entryText = ""
    @State var entryNumber: Double = 5

    var body: some View {
        WithViewStore(store) { viewStore in
            Color(ColorNameManager.Grey.cloud).edgesIgnoringSafeArea(.all).overlay(
                VStack(alignment: .leading) {
                    let roundNumber = viewStore.state.entryRoundNumber
                    Text(viewStore.state.mainQuestionAnswers.questionsAnswers[roundNumber].question)
                        .font(Font.custom(FontNameManager.Montserrat.regular, size: 25))
                    if viewStore.state.mainQuestionAnswers.questionsAnswers[roundNumber].isTextAnswer {
                        TextField("Type here", text: $entryText)
                            .font(Font.custom(FontNameManager.Montserrat.light, size: 20))
                        Button(action: {
                            viewStore.send(.answer(enteredAnswer: .text(self.entryText)))
                            self.entryText = ""

                        }, label: {
                            if self.entryText == "" {
                                Text("Skip")
                                    .font(Font.custom(FontNameManager.Montserrat.semiBold, size: 20))
                                    .accentColor(Color(ColorNameManager.Green.forrest))
                            } else {
                                Text("Save")
                                    .font(Font.custom(FontNameManager.Montserrat.semiBold, size: 20))
                                    .accentColor(Color(ColorNameManager.Green.forrest))
                            }
                        })

                    } else {
                        Slider(value: $entryNumber, in: 0...10, step: 1.0)
                            .accentColor(Color("ForrestGreen"))
                        Button(action: {
                            viewStore.send(.answer(enteredAnswer: .slider(Int(self.entryNumber))))
                        }, label: {
                            Text("Save \(Int(entryNumber))")
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
        JournalingView(store: ModuleStore(initialState: ModuleState(), reducer: reducer, environment: ()))
    }
}

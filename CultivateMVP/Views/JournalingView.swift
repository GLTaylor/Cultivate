import SwiftUI

struct JournalingView: View {
    @ObservedObject var store: AppStore
    @State var entryText = ""
    @State var entryNumber: Double = 5

   var body: some View {
       VStack(alignment: .leading) {
        Text(store.state.mainQuestionAnswers.questionsAnswers[store.state.entryRoundNumber].question)
            .font(Font.custom(FontNameManager.Montserrat.regular, size: 25))
        if store.state.mainQuestionAnswers.questionsAnswers[store.state.entryRoundNumber].isTextAnswer {

            TextField("Type here",
                      text: $entryText,
                  onEditingChanged: {
                    print("Editing changed? \($0)")

                }
            ).font(Font.custom(FontNameManager.Montserrat.light, size: 20))
            Button(action: {
                self.store.send(.answer(enteredAnswer: .text(self.entryText)))
                self.entryText = ""
                print(self.store.state.answeredQuestionAnswers)

            }, label: {
                Text("Save")
                    .font(Font.custom(FontNameManager.Montserrat.semiBold, size: 20))
                    .accentColor(Color("ForrestGreen"))

            })

        } else {
            Slider(value: $entryNumber, in: 0...10, step: 1.0)
                .accentColor(Color("ForrestGreen"))
            Button(action: {
                self.store.send(.answer(enteredAnswer: .slider(Int(self.entryNumber))))
            }, label: {
                let intVersionOfNumber = Int(entryNumber)
                Text("Save \(intVersionOfNumber)")
                    .font(Font.custom(FontNameManager.Montserrat.semiBold, size: 20))
                    .accentColor(Color("ForrestGreen"))

            })
        }
       }.padding()
   }
}

struct  JournalingView_Previews: PreviewProvider {
    static var previews: some View {
        JournalingView(store: AppStore(initialState: AppState(), reducer: reducer))
    }
}

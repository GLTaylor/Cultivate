import SwiftUI
import BedrockModels
import DesignKit

public struct SingleEntryView: View {
    let activity: EntryHistory.Activity

    public init(activity: EntryHistory.Activity) {
        self.activity = activity
    }

    let bigDateFont = Font.custom(FontNameManager.PTSerif.bold, size: 40)
    let pastEntryTitle = Font.custom(FontNameManager.Montserrat.italic, size: 20)
    let pastEntryText = Font.custom(FontNameManager.Montserrat.medium, size: 15)

    // To Do: display nothing if you've skipped everything

    public var body: some View {
        VStack {
            Text(EntryDateFormatter.string(from: activity.timestamp))
                .font(bigDateFont)

            ForEach(activity.resultSet) { set in
                if case JournalQuestionAnswer.Answer.text(let string) = set.answer {
                    if string != "" {
                        Text(set.question)
                            .font(pastEntryTitle)
                            .padding()
                        Text("You answered: \(string)")
                            .padding(.leading, 20)
                            .padding(.trailing, 20)

                    }
                }
            }
        }
    }
}

struct SingleEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let activity = EntryHistory.Activity.init(
            id: UUID(),
            timestamp: Date(timeIntervalSinceNow: 10),
            resultSet: [
                .init(id: .fakeUUID, question: "How are you doing with everything?", answer: .text("Great")),
                .init(id: .fakeUUID, question: "How are you doing with everything?", answer: .text("")),
                .init(id: .fakeUUID, question: "What's your favorite number?", answer: .slider(6)),
                .init(id: .fakeUUID, question: "What's on your mind?", answer: .text("Going home for Christmas")),
                .init(id: .fakeUUID, question: "What did you eat for breakfast?", answer: .text("Oatmeal and it was so good."))
            ]
        )
        return SingleEntryView(activity: activity)
    }
}

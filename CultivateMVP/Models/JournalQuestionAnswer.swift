import Foundation

struct JournalQuestionAnswer {
    let question: String
    var answer: Answer

    enum Answer {
        case slider(Int)
        case text(String)
    }
}

struct JournalQuestionsAnswers {
    var questionsAnswers: [JournalQuestionAnswer]

    static let defaultQuestionsAnswers = JournalQuestionsAnswers(questionsAnswers: [
        .init(question: "How are you feeling today?", answer: .slider(0)),
        .init(question: "What's on your mind right now?", answer: .text("")),
        .init(question: "What are you thankful for today?", answer: .text("")),
        .init(question: "What is a beautiful thing you've seen?", answer: .text("")),
        .init(question: "What do you want your friends to ask you?", answer: .text("")),
        .init(question: "What's something you want to tell your tomorrow self?", answer: .text(""))
    ])
}

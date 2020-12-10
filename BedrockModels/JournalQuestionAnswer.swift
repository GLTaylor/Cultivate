import Foundation

public struct JournalQuestionAnswer: Equatable {
    public let question: String
    public var answer: Answer

    public init(question: String, answer: Answer) {
        self.question = question
        self.answer = answer
    }

    public enum Answer: Equatable {
        case slider(Int)
        case text(String)
    }

    public var isTextAnswer: Bool {
        switch answer {
        case .slider:
            return false
        case .text:
            return true
        }
    }
}

public struct JournalQuestionsAnswers: Equatable {
    public var questionsAnswers: [JournalQuestionAnswer]

    public init(questionsAnswers: [JournalQuestionAnswer]) {
        self.questionsAnswers = questionsAnswers
    }

    public static let defaultQuestionsAnswers = JournalQuestionsAnswers(questionsAnswers: [
        .init(question: "How are you feeling today?", answer: .slider(0)),
        .init(question: "What's on your mind right now?", answer: .text("")),
        .init(question: "What are you thankful for today?", answer: .text("")),
        .init(question: "What is a beautiful thing you've seen?", answer: .text("")),
        .init(question: "What do you want your friends to ask you?", answer: .text("")),
        .init(question: "What's something you want to tell your tomorrow self?", answer: .text(""))
    ])
}

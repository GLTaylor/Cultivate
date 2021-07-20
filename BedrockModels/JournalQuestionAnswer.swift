import Foundation
import SavingServiceKit

public struct JournalQuestionAnswer: Equatable, Identifiable {
    public let question: String
    public let answer: Answer
    public let id: UUID

    public init(id: UUID = UUID(), question: String, answer: Answer) {
        self.question = question
        self.answer = answer
        self.id = id
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

public extension JournalQuestionAnswer {
    init(from model: SavableQuestionAnswer) {
        self.init(id: model.id,
                  question: model.question,
                  answer: .init(from: model.answer))
    }
}

public extension JournalQuestionAnswer.Answer {
    init(from model: SavableQuestionAnswer.Answer) {
        switch model {
        case let .slider(value):
            self = .slider(value)
        case let .text(value):
            self = .text(value)
        }
    }
}

public extension EntryHistory.Activity {
    init(from model: SavableActivity) {
        self.init(id: model.id,
                  timestamp: model.timestamp,
                  resultSet: model.resultSet.map(JournalQuestionAnswer.init))
    }
}

public extension SavableQuestionAnswer {
    init(from model: JournalQuestionAnswer) {
        self.init(id: model.id,
                  question: model.question,
                  answer: .init(from: model.answer))
    }
}

public extension SavableQuestionAnswer.Answer {
    init(from model: JournalQuestionAnswer.Answer) {
        switch model {
        case let .slider(value):
            self = .slider(value)
        case let .text(value):
            self = .text(value)
        }
    }
}

public extension SavableActivity {
    init(from model: EntryHistory.Activity) {
        self.init(id: model.id,
                  timestamp: model.timestamp,
                  resultSet: model.resultSet.map(SavableQuestionAnswer.init))
    }
}

import Foundation

// The JournalOptions scene will have several Entries annd one moodEntry
struct Entry {
    let question: String
    let answer: String?
}

struct MoodEntry {
    let moodQuestion: String
    let moodRating: Int?
}

struct JournalQuestion {
    let question: String
    let answerType: AnswerType

    enum AnswerType {
        case slider
        case text
    }
}

struct JournalQuestions {
    let questions: [JournalQuestion]

    static let defaultQuestions: [JournalQuestion] = [
        .init(question: "How are you feeling today?", answerType: .slider),
        .init(question: "What's on your mind right now?", answerType: .text),
        .init(question: "What are you thankful for today?", answerType: .text),
        .init(question: "What is a beautiful thing you've seen?", answerType: .text),
        .init(question: "What do you want your friends to ask you?", answerType: .text),
        .init(question: "What's something you want to tell your tomorrow self?", answerType: .text)
    ]
}

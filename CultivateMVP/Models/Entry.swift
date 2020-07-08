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

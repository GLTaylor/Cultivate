import Foundation

protocol JournalOptionsViewModelType {
    var entries: [Entry] { get }
    var moodEntry: MoodEntry { get }
}

struct JournalOptionsViewModel: JournalOptionsViewModelType {

    var entries: [Entry]
    var moodEntry: MoodEntry

    init(entries: [Entry], moodEntry: MoodEntry?) {
        self.entries = entries
        self.moodEntry = moodEntry ?? MoodEntry(moodQuestion: "Give mood", moodRating: 0)
    }
}


import Foundation

protocol JournalOptionsViewModelType {
    var entries: [Entry] { get }
    var moodEngry: MoodEntry { get }
}

class JournalOptionsViewModel: JournalOptionsViewModelType {
    var entries: [Entry]
    var moodEntry: MoodEntry?

    init(entries: [Entry], moodEntry: MoodEntry?) {
        self.entries = entries
        self.moodEntry = moodEntry
    }
}

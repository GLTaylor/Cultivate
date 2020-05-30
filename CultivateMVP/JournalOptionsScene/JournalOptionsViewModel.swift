import Foundation

protocol JournalOptionsViewModelType {
    var entries: [Entry] { get }
    var moodEntry: MoodEntry { get }
}

struct JournalOptionsViewModel: JournalOptionsViewModelType {
    // responsiblity of VMs is just to convert domain layer like “Thought” into plain strings of UI. + navigation

    var entries: [Entry]
    var moodEntry: MoodEntry

    init(entries: [Entry], moodEntry: MoodEntry?) {
        self.entries = entries
        self.moodEntry = moodEntry ?? MoodEntry(moodQuestion: "Give mood", moodRating: 0)
    }
}

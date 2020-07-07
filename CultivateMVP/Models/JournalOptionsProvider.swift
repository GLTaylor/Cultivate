import Foundation
import RxSwift
import RxCocoa

class JournalOptionsProvider {
    var entries: Observable<[Entry]>
    var moodEntry: Observable<MoodEntry>

    init() {
        let database = DatabaseOfJournalOptions()
        entries = Observable.from([database.initialEntries])
        moodEntry = Observable.just(database.initialMoodEntry)
    }
}

class DatabaseOfJournalOptions {
    // always want initial values, which at some point the user saves
    // How will this integrate with Core Data?

    var initialEntries: [Entry] = [Entry(question: "How Do You Feel?", answer: "Start Typing"), Entry(question: "What are you thinking?", answer: "Start Typing")]
    var initialMoodEntry: MoodEntry = .init(moodQuestion: "On a Scale of 1-10?", moodRating: 5)

}

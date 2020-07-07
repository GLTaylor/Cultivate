import Foundation

protocol JournalOptionsViewModelType {
    // to do - turn into plain UI things
    var entries: [Entry]? { get }
    var moodEntry: MoodEntry? { get }
}

class JournalOptionsViewModel: JournalOptionsViewModelType {

    var entries: [Entry]?
    var moodEntry: MoodEntry?
    private var provider: JournalOptionsProvider

    init(journalOptionsProvider: JournalOptionsProvider) {
        provider = journalOptionsProvider
        produceEntries()
        produceMoodEntries()
    }

    func produceEntries() {
        provider.entries.subscribe(
            onNext: { data in
                self.entries = data
        },
            onError: { error in
                print(error)
        },
            onCompleted: {
                print("completed entries")
        },
            onDisposed: {
                print("disposed entries")
            }).dispose()
    }

    func produceMoodEntries() {
        provider.moodEntry.subscribe(
              onNext: { data in
                  self.moodEntry = data
          },
              onError: { error in
                  print(error)
          },
              onCompleted: {
                  print("completed mood entries")
          },
              onDisposed: {
                  print("disposed mood entries")
              }).dispose()
    }
}

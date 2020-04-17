import UIKit

enum Scene {
    case thoughtOfDay(ThoughtOfDayViewModel)
    case journalOptions(JournalOptionsViewModel)
    case finished // Todo
}

class SceneFactory {

    private let thoughtOfDayVMThought: Thought
    private let journalOptionsVMEntries: [Entry]
    private let journalOptionsVMMoodEntry: MoodEntry
    // todo: third screen

   // there must be a better way to do this? Should I create a collection of dependencies and a converter of some kind and initialize with that?
    init(thoughtOfDayViewModelThought: Thought, journalOptionsViewModelEntries: [Entry], journalOptionsViewModelMoodEntry: MoodEntry) {
        thoughtOfDayVMThought = thoughtOfDayViewModelThought
        journalOptionsVMEntries = journalOptionsViewModelEntries
        journalOptionsVMMoodEntry = journalOptionsViewModelMoodEntry
    }

    func make(scene: Scene) -> UIViewController {
        let vc: UIViewController
        switch scene {
        case .thoughtOfDay:
            let vm = ThoughtOfDayViewModel(thoughtOfDay: thoughtOfDayVMThought)
            vc = ThoughtOfDayViewController(viewModel: vm)
        case .journalOptions:
            let vm = JournalOptionsViewModel(entries: journalOptionsVMEntries, moodEntry: journalOptionsVMMoodEntry)
            vc = JournalOptionsViewContoller(viewModel: vm)
        case .finished:
            // third screen, will set up later
            vc = UIViewController()
        }
        return vc
     }
}

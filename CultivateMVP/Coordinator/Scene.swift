import UIKit

enum Scene {
    case thoughtOfDay
    case journalOptions
    case finished // Todo
}

struct SceneFactory {

    private let thoughts: ThoughtProvider
    private let journalOptions: JournalOptionsProvider

    init(thoughtProvider: ThoughtProvider, journalOptionsProvider: JournalOptionsProvider) {
        thoughts = thoughtProvider
        journalOptions = journalOptionsProvider
    }

    // the scene factory needs to make a scene without VM's taking data. VMs should handle navigation and convert domain layer like Thought into plain strings of UI. Instead of injecting data into view models, need to inject a dependency that provides data."
    func make(scene: Scene) -> UIViewController {
        let vc: UIViewController
        switch scene {
        case .thoughtOfDay:
            let vm = ThoughtOfDayViewModel(thoughtProvider: thoughts)
            vc = ThoughtOfDayViewController(viewModel: vm)
        case .journalOptions:
            let vm = JournalOptionsViewModel(journalOptionsProvider: journalOptions)
            vc = JournalOptionsViewContoller(viewModel: vm)
        case .finished:
            // third screen, will set up later
            vc = UIViewController()
        }
        return vc
     }
}

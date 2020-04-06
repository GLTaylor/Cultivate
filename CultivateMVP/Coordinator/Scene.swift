import UIKit

enum Scene {
    case thoughtOfDay(ThoughtOfDayViewModel)
    case journalOptions(JournalOptionsViewModel)
    case finished // Todo
}

class SceneFactory {

    private let thoughtOfDayVM: ThoughtOfDayViewModel
    private let journalOptionsVM: JournalOptionsViewModel
    // todo: third screen

    // every time I create new scenes I could just add them here?, would be nice

    init(thoughtOfDayViewModel: ThoughtOfDayViewModel, journalOptionsViewModel: JournalOptionsViewModel) {
        thoughtOfDayVM = thoughtOfDayViewModel
        journalOptionsVM = journalOptionsViewModel
    }

    func make(scene: Scene) -> UIViewController {
        let vc: UIViewController
        switch scene {
        case .thoughtOfDay(let vm):
            vc = ThoughtOfDayViewController(viewModel: vm)
        case .journalOptions(let vm):
            vc = JournalOptionsViewContoller(viewModel: vm)
        case .finished:
            // third screen, will set up later
            vc = UIViewController()
        }
        return vc
     }
}

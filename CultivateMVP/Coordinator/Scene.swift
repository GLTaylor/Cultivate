import UIKit

enum Scene {
    case thoughtOfDay
    case journaling
    case finished // Todo
}

class SceneFactory {

    private weak var sceneCoordinator: SceneCoordinatorType!

    func setup(with sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }

    init() {
    }

    // the scene factory needs to make a scene without VM's taking data. VMs should handle navigation and convert domain layer like Thought into plain strings of UI. Instead of injecting data into view models, need to inject a dependency that provides data."
    func make(scene: Scene) -> UIViewController {
        let vc: UIViewController
        switch scene {
        case .thoughtOfDay:
            let vm = ThoughtOfDayViewModel(sceneCoordinator: sceneCoordinator)
            vc = ThoughtOfDayViewController(viewModel: vm)
        case .journaling:
            let vm = JournalingViewModel()
            vc = JournalingViewContoller(viewModel: vm)
        case .finished:
            // third screen, will set up later
            vc = UIViewController()
        }
        return vc
     }
}

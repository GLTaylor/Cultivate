//import UIKit
//
//enum Scene {
//    case thoughtOfDay
//    case journaling
//}
//
//class SceneFactory {
//
//    private weak var sceneCoordinator: SceneCoordinatorType!
//
//    func setup(with sceneCoordinator: SceneCoordinatorType) {
//        self.sceneCoordinator = sceneCoordinator
//    }
//
//    func make(scene: Scene) -> UIViewController {
//        let vc: UIViewController
//        switch scene {
//        case .thoughtOfDay:
//            let vm = ThoughtOfDayViewModel(sceneCoordinator: sceneCoordinator)
//            vc = ThoughtOfDayViewController(viewModel: vm)
//        case .journaling:
//            let vm = JournalingViewModel(sceneCoordinator: sceneCoordinator)
//            vc = JournalingViewContoller(viewModel: vm)
//        }
//        return vc
//     }
//}

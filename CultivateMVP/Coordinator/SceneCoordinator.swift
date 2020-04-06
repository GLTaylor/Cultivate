import Foundation
import RxSwift
import RxCocoa

protocol SceneCoordinatorType {
    init(window: UIWindow, factory: SceneFactory)
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void>

    @discardableResult
    func pop(animated: Bool) -> Observable<Void>
}

struct SceneCoordinator: SceneCoordinatorType {

    //I think I can put the first one for this in the app delegate
    private let vCFactory: SceneFactory
    private let navigationController = UINavigationController()

    init(window: UIWindow, factory: SceneFactory) {
        window.rootViewController = navigationController
        vCFactory = factory
    }

    static func actualViewController(for viewController: UIViewController) -> UIViewController {
      if let navigationController = viewController as? UINavigationController {
        return navigationController.viewControllers.first!
      } else {
        return viewController
      }
    }

    // finish
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Observable<Void> {
        let subject = PublishSubject<Void>()
        let viewController = vCFactory.make(scene: scene)
        switch type {
        case .root:
            navigationController.setViewControllers([viewController], animated: false)
            return .just(())
        case .push:
            //from the book:
            _ = navigationController.rx.delegate
                         .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                         .map { _ in }
                         .bind(to: subject)
                     navigationController.pushViewController(viewController, animated: true)
                     return subject
        case .modal:
            // not sure if this one is right

            let currentVC = SceneCoordinator.actualViewController(for: viewController)
            currentVC.present(viewController, animated: true) {
                subject.onCompleted()
            }
            // def wrong, just need to handle return for now
            return .just(())
            //Todo: set current viewController to the right one again?
        }
    }

    //maybe this
    func pop(animated: Bool) -> Observable<Void> {
        // Todo: need to handle if modal
        let subject = PublishSubject<Void>()

        _ = navigationController.rx.delegate
          .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
          .map { _ in }
          .bind(to: subject)
        guard navigationController.popViewController(animated: animated) != nil else {
          fatalError("can't go back")
        }
        return subject
    }

}

enum SceneTransitionType {
  //can be extended

  case root       // make view controller the root view controller
  case push       // push view controller to navigation stack
  case modal      // present view controller modally
}

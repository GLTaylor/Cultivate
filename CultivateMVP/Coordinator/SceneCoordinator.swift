import Foundation
import RxSwift


protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable

    @discardableResult
    func pop(animated: Bool) -> Completable
}

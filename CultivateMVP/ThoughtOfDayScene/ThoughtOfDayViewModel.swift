import Foundation
import RxCocoa
import RxSwift

protocol ThoughtOfDayViewModelType {
     var viewState: Driver<ThoughtsOfDayViewState> { get }
}

class ThoughtOfDayViewModel: ThoughtOfDayViewModelType {
    var viewState: Driver<ThoughtsOfDayViewState> = .never()

    init(sceneCoordinator: SceneCoordinatorType) {
        viewState = .just(.init(journalNowButtonTapped: {
            sceneCoordinator.transition(to: .journaling, type: .push)
        }))
    }

}

struct ThoughtsOfDayViewState {
    let journalNowButtonTapped: () -> Void
}

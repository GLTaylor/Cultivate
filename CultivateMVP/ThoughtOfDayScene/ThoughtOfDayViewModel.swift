import Foundation
import RxCocoa
import RxSwift

protocol ThoughtOfDayViewModelType {
     var viewState: Driver<ThoughtsOfDayViewState> { get }
}

class ThoughtOfDayViewModel: ThoughtOfDayViewModelType {
    var viewState: Driver<ThoughtsOfDayViewState> = .never()

    private var thoughtOfDayProvider: ThoughtProvider

    init(thoughtProvider: ThoughtProvider) {
        thoughtOfDayProvider = thoughtProvider
        viewState = thoughtOfDayProvider.thought.map {
            ThoughtsOfDayViewState(thought: $0.text)
        }.asDriver(onErrorDriveWith: .never())
    }

}

struct ThoughtsOfDayViewState {
    // later to be array
    let thought: String
}

import Foundation
import RxCocoa
import RxSwift

protocol ThoughtOfDayViewModelType {
    var thoughtOfDay: String? { get }
}

class ThoughtOfDayViewModel: ThoughtOfDayViewModelType {

    var thoughtOfDay: String?
    private var thoughtOfDayProvider: ThoughtProvider

    init(thoughtProvider: ThoughtProvider) {
        thoughtOfDayProvider = thoughtProvider
        produceThoughts()
    }

    func produceThoughts() {
        thoughtOfDayProvider.thought.subscribe { event in
            switch event {
            case .next(let thought):
                self.thoughtOfDay  = thought.text
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
        }.dispose()
    }
}

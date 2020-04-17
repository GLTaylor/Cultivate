import Foundation

protocol ThoughtOfDayViewModelType {
    var thoughtOfDay: Thought { get }
}

class ThoughtOfDayViewModel: ThoughtOfDayViewModelType {
    var thoughtOfDay: Thought

    init(thoughtOfDay: Thought) {
        self.thoughtOfDay = thoughtOfDay
    }
}

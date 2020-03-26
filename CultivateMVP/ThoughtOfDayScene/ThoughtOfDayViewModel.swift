import Foundation

protocol ThoughtOfDayViewModelType {
    var thoughtOfDay: Thought { get }

    // inputs
    // outputs
    // is this necessary?
}

class ThoughtOfDayViewModel: ThoughtOfDayViewModelType {
    var thoughtOfDay: Thought

    init(thoughtOfDay: Thought) {
        self.thoughtOfDay = thoughtOfDay
    }
}

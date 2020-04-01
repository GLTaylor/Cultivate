import Foundation

protocol ThoughtOfDayViewModelType {
    var thoughtOfDay: Thought { get }

    // the create-next-VM function, see comment below
}

class ThoughtOfDayViewModel: ThoughtOfDayViewModelType {
    var thoughtOfDay: Thought

    init(thoughtOfDay: Thought) {
        self.thoughtOfDay = thoughtOfDay
    }

    // the book says:
    // 1.  A view model creates the view model for the next scene.
    // 2.  The first view model initiates the transition to the next scene by calling into the scene coordinator.
    // Todo: the above.
    // Difference is: I don't want to use storyboard like they do in the book.

}

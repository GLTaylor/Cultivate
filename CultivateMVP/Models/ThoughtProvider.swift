import Foundation
import RxSwift
import RxCocoa

class ThoughtProvider {
    var thought: Observable<Thought>

    init() {
        let data = Observable.just(DatabaseOfThoughts().theOnlyThoughtForNow)
        thought = data
    }
}

class DatabaseOfThoughts {
    // later it will be a whole array, or a json, or something similar
    var theOnlyThoughtForNow: Thought

    init() {
        theOnlyThoughtForNow = Thought(text: "Do or do not there is no try")
    }
}

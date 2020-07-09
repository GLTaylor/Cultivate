import Foundation
import RxSwift
import RxCocoa

class JournalOptionsProvider {
    var journalQuestions: Observable<[JournalQuestion]>

    init() {
        journalQuestions = Observable.just(JournalQuestions.defaultQuestions)
    }
}

class DatabaseOfJournalOptions {
    // to do - save answers
    // How will this integrate with Core Data?

}

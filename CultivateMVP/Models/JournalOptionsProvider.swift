import Foundation
import RxSwift
import RxCocoa

class JournalOptionsProvider {
    var journalQuestions: Observable<[JournalQuestion]>

    init() {
        journalQuestions = Observable.just([JournalQuestion(question: "How Do You Feel?", answerType: .text)])
    }
}

class DatabaseOfJournalOptions {
    // to do - save answers
    // How will this integrate with Core Data?

}

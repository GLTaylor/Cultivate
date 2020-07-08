import Foundation
import RxCocoa
import RxSwift

protocol JournalOptionsViewModelType {
    var viewState: Driver<JournalOptionsViewState> { get }
}

struct JournalOptionsViewModel: JournalOptionsViewModelType {

    var viewState: Driver<JournalOptionsViewState> = .never()
    private var provider: JournalOptionsProvider

    init(journalOptionsProvider: JournalOptionsProvider) {
        provider = journalOptionsProvider
            // how to handle an array? Probably include a button, and on tap, go to the next in the array...

        viewState = provider.journalQuestions.map {
            return JournalOptionsViewState(
                journalQuestion: $0.first?.question,
                journalAnswer: "Type",
                moodQuestion: nil,
                moodAnswer: nil,
                nextButtonAction: nil
                )
        }.asDriver(onErrorDriveWith: .never())

    }
}

struct JournalOptionsViewState {
    let journalQuestion: String?
    let journalAnswer: String?
    let moodQuestion: String?
    let moodAnswer: Int?
    let nextButtonAction: (() -> Void)?
}

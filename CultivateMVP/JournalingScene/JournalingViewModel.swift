import Foundation
import RxCocoa
import RxSwift

protocol JournalingViewModelType {
    var viewState: Driver<JournalingViewState> { get }
    var inputEvents: PublishRelay<JournalingEvent> { get }
}

class JournalingViewModel: JournalingViewModelType {
    var inputEvents: PublishRelay<JournalingEvent>


    var viewState: Driver<JournalingViewState> = .never()
    private let questionNumber = BehaviorSubject<Int>(value: 0)
    var questionsAnswers: JournalQuestionsAnswers

    init(questionsAnswers: JournalQuestionsAnswers = .defaultQuestionsAnswers) {
        self.questionsAnswers = questionsAnswers

        inputEvents.subscribe(
            onNext: { event in
                switch event {
                case .sliderNumberChanged(_):
//                  set answer (change value in questionsAnswers)
                case .textEntered(_):
//                  set answer (change value in questionsAnswers)
                case .buttonTapped:
                    //next button tapped action
                case .finishButtonTapped:
                    // finish -> last screen, save everything, coordinator closes screen
                }
            }
            )

        viewState = questionNumber.map { number in

            JournalingViewState(
                date: "later",
                sliderPosition: number,
                questionsCount: self.questionsAnswers.questionsAnswers.count,
                question: self.questionsAnswers.questionsAnswers[number].question,
                answerType: .slider, // later,
                button: .next // logic for button there will be a last button)
            )
        }.asDriver(onErrorDriveWith: .never())
    }
}

enum JournalingEvent {
    case sliderNumberChanged(Int)
    case textEntered(String)
    case buttonTapped
    case finishButtonTapped
}

struct JournalingViewState {
    let date: String
    let sliderPosition: Int
    let questionsCount: Int
    let question: String
    let answerType: AnswerType
    let button: Button

    enum AnswerType { case slider, text }
    enum Button {
        case next, finish
    }
}

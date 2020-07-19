import Foundation
import RxCocoa
import RxSwift

protocol JournalingViewModelType {
    var viewState: Driver<JournalingViewState> { get }
}

final class JournalingViewModel: JournalingViewModelType {
    var viewState: Driver<JournalingViewState> = .never()
    private let questionNumber = BehaviorSubject<Int>(value: 0)
    var questionsAnswers: JournalQuestionsAnswers

    init(questionsAnswers: JournalQuestionsAnswers = .defaultQuestionsAnswers) {
        self.questionsAnswers = questionsAnswers

        viewState = questionNumber.flatMap { [weak self] number -> Observable<JournalingViewState> in
            guard let self = self else {
                return .empty()
            }
            return .just(self.makeViewState(with: number))
        }.asDriver(onErrorDriveWith: .never())
    }

    private func makeViewState(with questionNumber: Int) -> JournalingViewState {
        let answerType: JournalingViewState.AnswerType
        switch self.questionsAnswers.questionsAnswers[questionNumber].answer {
        case .slider:
            answerType = .slider({ value in
                self.questionsAnswers.questionsAnswers[questionNumber].answer = .slider(value)
            })
        case .text:
            answerType = .text({ value in
                self.questionsAnswers.questionsAnswers[questionNumber].answer = .text(value)
            })
        }

        let button: JournalingViewState.Button = questionNumber >= questionsAnswers.questionsAnswers.count - 1
            ? .finish({
                // save questionsAnswers to the DB
                // coordinator.close the screen
            })
            : .next({
                self.questionNumber.on(.next(questionNumber + 1))
            })

        return JournalingViewState(
            date: "later",
            sliderPosition: questionNumber,
            questionsCount: questionsAnswers.questionsAnswers.count,
            question: questionsAnswers.questionsAnswers[questionNumber].question,
            answerType: answerType,
            button: button
        )
    }
}

struct JournalingViewState {
    let date: String
    let sliderPosition: Int
    let questionsCount: Int
    let question: String
    let answerType: AnswerType
    let button: Button

    enum AnswerType {
        case slider((Int) -> Void)
        case text((String) -> Void)
    }

    enum Button {
        case next(() -> Void)
        case finish(() -> Void)
    }
}

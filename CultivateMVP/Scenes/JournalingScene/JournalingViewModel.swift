import Foundation
import RxCocoa
import RxSwift

protocol JournalingViewModelType {
    var viewState: Driver<JournalingViewState> { get }
}

final class JournalingViewModel: JournalingViewModelType {
    private let sceneCoordinator: SceneCoordinatorType

    var viewState: Driver<JournalingViewState> = .never()
    private let questionNumber = BehaviorSubject<Int>(value: 0)
    private var questionsAnswers: JournalQuestionsAnswers

    init(sceneCoordinator: SceneCoordinatorType,
         questionsAnswers: JournalQuestionsAnswers = .defaultQuestionsAnswers) {
        self.sceneCoordinator = sceneCoordinator
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
        switch questionsAnswers.questionsAnswers[questionNumber].answer {
        case .slider:
            answerType = .slider({ [weak self] value in
                self?.questionsAnswers.questionsAnswers[questionNumber].answer = .slider(value)
            })
        case .text:
            answerType = .text({ [weak self] value in
                self?.questionsAnswers.questionsAnswers[questionNumber].answer = .text(value)
            })
        }

        let button: JournalingViewState.Button = questionNumber >= questionsAnswers.questionsAnswers.count - 1
            ? .finish({ [weak self] in
                // save questionsAnswers to the DB
                self?.sceneCoordinator.pop(animated: true)
            })
            : .next({ [weak self] in
                self?.questionNumber.on(.next(questionNumber + 1))
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

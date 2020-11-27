import Foundation
import Combine

final class Store<State, Action>: ObservableObject {
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    private var effectCancelables: Set<AnyCancellable> = []

    init(initialState: State, reducer: @escaping Reducer<State, Action>) {
        self.state = initialState
        self.reducer = reducer
    }

    func send(_ action: Action) {
        guard let effect = reducer(&state, action) else { return }

        // AnyCancelable: A type-erasing cancellable object that executes a provided closure when canceled.
        // it's kind of like disposable thing (?)

        var effectCancellable: AnyCancellable?
        // sink is like subscribe
        effectCancellable = effect.sink(
            receiveCompletion: { [weak self] _ in
                if let effectCancellable = effectCancellable {
                    self?.effectCancelables.remove(effectCancellable)
                }
            },
            receiveValue: send
        )

        if let effectCancellable = effectCancellable {
            effectCancelables.insert(effectCancellable)
        }

    }
}

typealias Reducer<State, Action> = (inout State, Action) -> Effect<Action>?

public struct Effect<Output>: Publisher {
    public typealias Failure = Never

    let publisher: AnyPublisher<Output, Failure>

    public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        self.publisher.receive(subscriber: subscriber)
    }

}

extension Publisher where Failure == Never {
    public func eraseToEffect() -> Effect<Output> {
        return Effect(publisher: self.eraseToAnyPublisher())
    }
}

import SwiftUI

struct ThoughtOfDayView: View {
    @ObservedObject var store: AppStore

    var body: some View {
        Button(action: { self.store.send(.startJournaling)},
               label: { Text("Let's begin to cultivate or something")})
            .font(.title)
            .sheet(isPresented: Binding.constant(store.state.journalingHasStarted),
                   onDismiss: { self.store.send(.stopJournaling) },
                   content: { JournalingView(store: self.store) })
    }
}

    struct ThoughtOfDayView_Previews: PreviewProvider {
        static var previews: some View {
            return ThoughtOfDayView(store: AppStore(initialState: AppState(), reducer: reducer))
        }
    }

//    private let viewModel: ThoughtOfDayViewModelType
//    private let disposeBag = DisposeBag()
//
//    init(viewModel: ThoughtOfDayViewModelType) {
//        self.viewModel = viewModel
//        // why was this line down here required? mmm...
//        super.init(nibName: nil, bundle: nil)
//
//    }

//
//    private func configure(with viewState: ThoughtsOfDayViewState) {
//        // bind button action
//        journalButton.rx.tap.bind {
//            viewState.journalNowButtonTapped()
//        }.disposed(by: disposeBag)
//    }
//
//    override func viewDidLoad() {
//         super.viewDidLoad()
//         setUpLabelLayout()
//         setUpButtonLayout()
//
//        viewModel.viewState
//            .drive(onNext: { [weak self] in
//                self?.configure(with: $0)
//            })
//            .disposed(by: disposeBag)
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

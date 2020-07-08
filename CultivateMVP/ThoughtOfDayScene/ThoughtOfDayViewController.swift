import Foundation
import UIKit
import RxCocoa
import RxSwift

class ThoughtOfDayViewController: UIViewController {

    private let viewModel: ThoughtOfDayViewModelType
    private let disposeBag = DisposeBag()

    init(viewModel: ThoughtOfDayViewModelType) {
        self.viewModel = viewModel
        // why was this line down here required? mmm...
        super.init(nibName: nil, bundle: nil)

        journalButton.rx.tap.bind {
            print("TAP")
        }
    }

    private let thoughtLabel: UILabel = {
        let label = UILabel()
        //later
        label.textColor = .red
        return label
    }()

    private let journalButton: UIButton = {
        let button = UIButton()
        //button.text etc
        //later
        //style...
        button.backgroundColor = .darkGray
        button.titleLabel?.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
        return button
    }()

    private func setUpLabelLayout() {
        view.addSubview(thoughtLabel)
        thoughtLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        thoughtLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        thoughtLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: CGFloat(40)),
        thoughtLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
        thoughtLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
    }

    private func setUpButtonLayout() {
        view.addSubview(journalButton)
        journalButton.titleLabel?.text = "Journal Now"
        journalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        journalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        journalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configure(with viewState: ThoughtsOfDayViewState) {
        thoughtLabel.text = viewState.thought
    }

    override func viewDidLoad() {
         super.viewDidLoad()
         setUpLabelLayout()
         setUpButtonLayout()

        viewModel.viewState
            .drive(onNext: { [weak self] in
                self?.configure(with: $0)
            })
            .disposed(by: disposeBag)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

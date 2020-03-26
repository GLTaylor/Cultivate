import Foundation
import UIKit

class ThoughtOfDayViewController: UIViewController {

    private let viewModel: ThoughtOfDayViewModelType

    init(viewModel: ThoughtOfDayViewModelType){
        self.viewModel = viewModel
        // why was this line down here required? mmm...
        super.init(nibName: nil, bundle: nil)
    }

    private let thoughtLabel: UILabel = {
        let label = UILabel()
        //label.text = viewModel.thoughtOfday.text
        //later
        //label.font = M's fancy font
        return label
    }()

    private let journalButton: UIButton = {
        let button = UIButton()
        //button.text etc
        //later
        //style...
        button.backgroundColor = .darkGray
        button.titleLabel?.text = "Journal"
        button.titleLabel?.font = .monospacedSystemFont(ofSize: 14, weight: .bold)
        button.titleLabel?.textColor = .white
        return button
    }()

    private func setUpLabelLayout() {
        view.addSubview(thoughtLabel)
        thoughtLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        thoughtLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        thoughtLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: CGFloat(40))
        ])
    }

    private func setUpButtonLayout() {
        view.addSubview(journalButton)
        journalButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        journalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        thoughtLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                          constant: CGFloat(40))
        ])
    }


    override func viewDidLoad() {
         super.viewDidLoad()
         setUpLabelLayout()
         setUpButtonLayout()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

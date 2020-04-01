
import Foundation
import UIKit


class JournalOptionsViewContoller: UIViewController {
    private let viewModel: JournalOptionsViewModelType

    init(viewModel: JournalOptionsViewModelType){
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "To be continued"
        return label
    }()

    private func setUpLabelLayout() {
        view.addSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        firstLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewDidLoad() {
          super.viewDidLoad()
          setUpLabelLayout()
     }

}

import UIKit

protocol ResultsViewProtocol: AnyObject {
    
}

class ResultsViewController: UIViewController {

    @IBOutlet var poinsLabel: UILabel!
    @IBOutlet var congratsLabel: UILabel!
    @IBOutlet var homeButtton: UIButton!
    
    var presenter: ResultsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        poinsLabel.text = presenter.getPointsString()
        congratsLabel.text = presenter.getCongratsString()
    }

    @IBAction func homeButtonPressed() {
        let welcomeViewController = ModuleBuilder.createWelcomeModule()
        navigationController?.pushViewController(welcomeViewController, animated: true)
    }
}

extension ResultsViewController: ResultsViewProtocol {
    
}

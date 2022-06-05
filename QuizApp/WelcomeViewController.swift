import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet var readyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func readyTouch(_ sender: Any) {
        let setupViewController = ModuleBuilder.createQuizSetupModule()
        navigationController?.pushViewController(setupViewController, animated: true)
    }
}


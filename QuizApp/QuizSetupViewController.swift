import UIKit

class QuizSetupViewController: UIViewController {

    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var difficultySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func difficultySliderMoved(_ sender: Any) {
        self.difficultySlider.value = round(difficultySlider.value)
    }
}

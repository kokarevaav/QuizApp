import UIKit

protocol SetupViewProtocol: AnyObject {
    func getSelectedCategory() -> String
    func getDifficultyLevel() -> Float
}

class QuizSetupViewController: UIViewController {

    @IBOutlet var categoryPicker: UIPickerView!
    @IBOutlet var difficultySlider: UISlider!
    @IBOutlet var doneButton: UIButton!
    
    var presenter: SetupPresenterProtocol!
    var selectedCategory: String! = "General Knowledge"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        categoryPicker.setValue(UIColor.white, forKey: "textColor")
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
        
    }

    @IBAction func difficultySliderMoved(_ sender: Any) {
        self.difficultySlider.value = round(difficultySlider.value)
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let quizViewController = ModuleBuilder.createQuizModule(difficulty: presenter.getSettings().difficulty, category: presenter.getSettings().category)
        navigationController?.pushViewController(quizViewController, animated: true)
        
    }
}

extension QuizSetupViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.getCategoriesList().count
    }
}

extension QuizSetupViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getCategoriesList()[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = presenter.getCategoriesList()[row]
    }
}

extension QuizSetupViewController: SetupViewProtocol {
    func getSelectedCategory() -> String {
        return selectedCategory
    }
    
    func getDifficultyLevel() -> Float {
        return round(difficultySlider.value)
    }
}

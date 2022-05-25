import UIKit

protocol QuizViewProtocol: AnyObject {
    func reloadView()
}

class QuizViewController: UIViewController {

    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answer1Button: UIButton!
    @IBOutlet var answer2Button: UIButton!
    @IBOutlet var answer3Button: UIButton!
    
    var presenter: QuizPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if (presenter.getQuestions().isEmpty) {
            questionLabel.text = ""
            answer1Button.titleLabel?.text = ""
            answer2Button.titleLabel?.text = ""
            answer3Button.titleLabel?.text = ""
        } else {
            questionLabel.text = presenter.getQuestions()[0].question
            answer1Button.setTitle(presenter.getQuestions()[0].incorrectAnswers![0], for: .normal)
            answer2Button.setTitle(presenter.getQuestions()[0].correctAnswer, for: .normal)
            answer3Button.setTitle(presenter.getQuestions()[0].incorrectAnswers![1], for: .normal) 
        }
       
    }

}

extension QuizViewController: QuizViewProtocol {
    func reloadView() {
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
    }
}

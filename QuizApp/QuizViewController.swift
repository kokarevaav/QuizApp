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
        
        if let question = presenter.getCurrQuestion() {
            questionLabel.text = question.question
            answer1Button.setTitle(question.correctAnswer, for: .normal)
            answer2Button.setTitle(presenter.getAnswers()[0], for: .normal)
            answer3Button.setTitle(presenter.getAnswers()[1], for: .normal)
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

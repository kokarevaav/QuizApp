import UIKit

enum QuizError: Error {
    case endOfQuestions
}

protocol QuizViewProtocol: AnyObject {
    func reloadView()
}

class QuizViewController: UIViewController {

    @IBOutlet var buttonsView: ButtonsMaker!
    @IBOutlet var questionLabel: UILabel!
    
    var presenter: QuizPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    @objc func buttonAction(sender: UIButton) {
        let isCorrect = presenter.checkAnswer(answer: (sender.currentTitle!))
        sender.backgroundColor = isCorrect ? .green : .red
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] in
            self!.moveToNextQuestion()
        })
    }
    
    func moveToNextQuestion() {
        guard !presenter.isEnd() else { return displayResults() }
        let answers = presenter.getAnswers()
        questionLabel.text = presenter.getQuestion()
        for i in answers.indices {
            let button = buttonsView.createButton(title: answers[i], number: i)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
        }
    }
    
    func displayResults() {
        let resultsViewController = ModuleBuilder.createResultsModule(points: presenter.getResults().points, amount: presenter.getResults().amount, category: presenter.getCategory())
        navigationController?.pushViewController(resultsViewController, animated: true)
    }
}

extension QuizViewController: QuizViewProtocol {
    func reloadView() {
        DispatchQueue.main.async {
            self.moveToNextQuestion()
            self.viewDidLoad()
        }
    }
}



import UIKit

enum QuizError: Error {
    case endOfQuestions
}

protocol QuizViewProtocol: AnyObject {
    func reloadView()
}

class QuizViewController: UIViewController {

    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var numberOfQuestionLabel: UILabel!
    @IBOutlet var buttonsView: ButtonsMaker!
    @IBOutlet var questionLabel: UILabel!
    var answerButton: UIButton!
    
    var numberOfCurrentQuestion = 0
    var presenter: QuizPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    @objc func buttonAction(sender: UIButton) {
        let isCorrect = presenter.checkAnswer(answer: (sender.currentTitle!))
        if (isCorrect) {
            sender.backgroundColor = Config.Colors.correctButtonColor
        } else {
            sender.backgroundColor = Config.Colors.incorrectButtonColor
            answerButton.backgroundColor = Config.Colors.correctButtonColor
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [weak self] in
            self!.moveToNextQuestion()
        })
    }
    
    func moveToNextQuestion() {
        guard !presenter.isEnd() else { return displayResults() }
        numberOfCurrentQuestion += 1
        numberOfQuestionLabel.text = "\(numberOfCurrentQuestion)/\(presenter.getResults().amount)"
        pointsLabel.text = "Your score: \(presenter.getResults().points)"
        let answers = presenter.getAnswers()
        questionLabel.text = presenter.getQuestion()
        for i in answers.indices {
            let button = buttonsView.createButton(title: answers[i], number: i)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            if (presenter.isCorrectAnswer(title: button.currentTitle!)) {
                answerButton = button
            }
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

extension QuizViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let welcomeViewController = ModuleBuilder.createWelcomeModule()
            self.navigationController?.pushViewController(welcomeViewController, animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}



import Foundation

protocol QuizPresenterProtocol: AnyObject {
    init(view: QuizViewProtocol)
    func getCurrQuestion() -> Result?
    func getAnswers() -> [String]
    func checkAnswer(answer: String)
}

class QuizPresenter: QuizPresenterProtocol {
    let view: QuizViewProtocol
    var questions: [Result]
    var amount: Int
    var points: Int
    var currentQuestion: Result?
    
    required init(view: QuizViewProtocol) {
        self.view = view
        self.questions = []
        self .currentQuestion = nil
        self.amount = 0
        self.points = 0
    }
    
    func getCurrQuestion() -> Result? {
        return currentQuestion
    }
    
    func getAnswers() -> [String] {
        var answers: [String] = []
        answers.append((currentQuestion?.correctAnswer!)!)
        answers.append((currentQuestion?.incorrectAnswers![0])!)
        answers.append((currentQuestion?.incorrectAnswers![1])!)
        answers = answers.shuffled()
        return answers
    }
    
    func checkAnswer(answer: String) {
        if (answer == currentQuestion?.correctAnswer) {
            points += 1
        }
        if let q = questions.popLast() {
            currentQuestion = q
        }
    }
    
}

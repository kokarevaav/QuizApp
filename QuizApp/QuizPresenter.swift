import Foundation

protocol QuizPresenterProtocol: AnyObject {
    init(view: QuizViewProtocol)
    func getAnswers() -> [String]
    func checkAnswer(answer: String) -> Bool
    func getQuestion() -> String?
    func getResults() -> (amount: Int, points: Int)
    func getCategory() -> TriviaCategory
    func isEnd() -> Bool
}

class QuizPresenter: QuizPresenterProtocol {
    let view: QuizViewProtocol
    var questions: [Result]
    var amount: Int
    var points: Int
    var currentQuestion: Result?
    var category: TriviaCategory
    
    required init(view: QuizViewProtocol) {
        self.view = view
        self.questions = []
        self .currentQuestion = nil
        self.amount = 0
        self.points = 0
        self.category = TriviaCategory(id: 9, name: "General Knowledge")
    }
    
    func getAnswers() -> [String] {
        guard let question = currentQuestion else { return [String]() }
        var answers: [String] = []
        answers.append(question.correctAnswer)
        for index in 0..<3 {
            answers.append(question.incorrectAnswers[index])
        }
        return answers.shuffled()
    }
    
    func getQuestion() -> String? {
        if let q = currentQuestion {
            return q.question
        }
        return .none
    }
    
    func checkAnswer(answer: String) -> Bool{
        guard let q = currentQuestion else { return false }
        currentQuestion = getNextQuestions()
        if (answer == q.correctAnswer) {
            points += 1
            return true
        }
        return false
    }
    
    func getNextQuestions() -> Result?{
        guard let q = questions.popLast() else { return .none }
        self.currentQuestion = q
        return currentQuestion
    }
    
    func getResults() -> (amount: Int, points: Int) {
        return (amount, points)
    }
    
    func getCategory() -> TriviaCategory {
        return category
    }
    
    func isEnd() -> Bool {
        guard currentQuestion != nil else { return true }
        return false
    }
}

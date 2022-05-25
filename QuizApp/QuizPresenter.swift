import Foundation

protocol QuizPresenterProtocol: AnyObject {
    init(view: QuizViewProtocol)
    func getQuestions() -> [Result]
    //func getAnswers() -> [[String]]
}

class QuizPresenter: QuizPresenterProtocol {
    let view: QuizViewProtocol
    var questions: [Result]
    var amount: Int = 0
    required init(view: QuizViewProtocol) {
        self.view = view
        self.questions = []
    }
    
    func getQuestions() -> [Result] {
        return questions
    }
    
//    func getAnswers() -> [[String]] {
//        if (questions.isEmpty) {
//            return
//        }
//        else {
//            var answersTitles: [[String]] = [[]]
//
//        }
//    }
}

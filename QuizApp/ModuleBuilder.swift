import UIKit
protocol Builder {
    static func createWelcomeModule() -> UIViewController
    static func createQuizSetupModule() -> UIViewController
    static func createQuizModule(difficulty: String, category: String) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createWelcomeModule() -> UIViewController {
        let quizView = WelcomeViewController()
        return quizView
    }
    
    static func createQuizSetupModule() -> UIViewController{
        let setUpView = QuizSetupViewController()
        let setupPresenter = SetupPresenter(view: setUpView)
        setUpView.presenter = setupPresenter
        return setUpView
    }
    
    static func createQuizModule(difficulty: String, category: String) -> UIViewController {
        let quizView = QuizViewController()
        let quizPresenter = QuizPresenter(view: quizView)
        ApiManager.apiManager.getQuestions(category: category, difficulty: difficulty) { data in
            quizPresenter.questions = data
            quizPresenter.currentQuestion = quizPresenter.questions.popLast()
            quizView.reloadView()
        }
        quizPresenter.amount = Int(AmountOfQuestions.amountDictionary[difficulty]!) ?? 0
        quizView.presenter = quizPresenter
        return quizView
    }
}

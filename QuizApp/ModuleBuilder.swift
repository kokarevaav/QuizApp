import UIKit
protocol Builder {
    static func createWelcomeModule() -> UIViewController
    static func createQuizSetupModule() -> UIViewController
    static func createQuizModule(difficulty: String, category: TriviaCategory) -> UIViewController
    static func createResultsModule(points: Int, amount: Int, category: TriviaCategory) -> UIViewController
}

class ModuleBuilder: Builder {
    static func createWelcomeModule() -> UIViewController {
        let quizView = WelcomeViewController()
        return quizView
    }
    
    static func createQuizSetupModule() -> UIViewController{
        let setUpView = QuizSetupViewController()
        let setupPresenter = SetupPresenter(view: setUpView)
        ApiManager.apiManager.getCategories() { category in
            setupPresenter.categories = category.map { category in
                    var c: TriviaCategory = category
                    c.name = category.name.replacingOccurrences(of: "Entertainment: ", with: "")
                    return c
                }
            setUpView.reloadView()
        }
        setUpView.presenter = setupPresenter
        return setUpView
    }
    
    static func createQuizModule(difficulty: String, category: TriviaCategory) -> UIViewController {
        let quizView = QuizViewController()
        let quizPresenter = QuizPresenter(view: quizView)
        ApiManager.apiManager.getQuestions(category: category, difficulty: difficulty) { data in
            quizPresenter.questions = data
            quizPresenter.category = category
            quizPresenter.currentQuestion = quizPresenter.questions.popLast()
            quizView.reloadView()
        }
        quizPresenter.amount = Int(AmountOfQuestions.amountDictionary[difficulty]!) ?? 0
        quizView.presenter = quizPresenter
        return quizView
    }
    
    static func createResultsModule(points: Int, amount: Int, category: TriviaCategory) -> UIViewController {
        let resultsView = ResultsViewController()
        let resultsPresenter = ResultsPresenter(points: points, amount: amount, category: category)
        resultsView.presenter = resultsPresenter
        return resultsView
    }
}

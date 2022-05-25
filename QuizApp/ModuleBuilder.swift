import UIKit
protocol Builder {
    static func createWelcomeModule() -> UIViewController
    static func createQuizSetupModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createWelcomeModule() -> UIViewController {
        let quizView = WelcomeViewController()
        return quizView
    }
    
    static func createQuizSetupModule() -> UIViewController{
        let setUpView = QuizSetupViewController()
        let quizPresenter = QuizPresenter(view: setUpView)
        setUpView.presenter = quizPresenter
        return setUpView
    }
}

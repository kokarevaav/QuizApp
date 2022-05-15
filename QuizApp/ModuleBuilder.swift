import UIKit
protocol Builder {
    static func createQuizModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createQuizModule() -> UIViewController {
        let quizView = WelcomeViewController()
        //let presenter = QuizPresenter(view: quizView)
        //quizView.presenter = presenter
        return quizView
    }
}

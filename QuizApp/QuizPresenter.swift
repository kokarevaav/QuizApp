import Foundation

protocol QuizPresenterProtocol: AnyObject {
    init(view: QuizViewProtocol)
    func getCategoriesList() -> [String]
    func addSettings()
}

class QuizPresenter: QuizPresenterProtocol {
    let view: QuizViewProtocol
    var difficulty: Float
    var category: String

    required init(view: QuizViewProtocol) {
        self.view = view
        self.difficulty = 0
        self.category = ""
    }
    
    func getCategoriesList() -> [String] {
        return Categories.categoriesList
    }
    
    func addSettings() {
        difficulty = view.getDifficultyLevel()
        category = view.getSelectedCategory()
    }
}

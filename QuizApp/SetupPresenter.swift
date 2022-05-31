import Foundation

protocol SetupPresenterProtocol: AnyObject {
    init(view: SetupViewProtocol)
    func getCategoriesList() -> [TriviaCategory]
    func getSettings() -> String
}

class SetupPresenter: SetupPresenterProtocol {
    let view: SetupViewProtocol
    var difficulty: String
    var categories: [TriviaCategory]

    required init(view: SetupViewProtocol) {
        self.view = view
        self.difficulty = ""
        self.categories = []
    }
    
    func getCategoriesList() -> [TriviaCategory] {
        return self.categories
    }
    
    func getSettings() -> String{
        difficulty = Difficulties.difficultyDictionary[view.getDifficultyLevel()]!
        return difficulty
    }
}

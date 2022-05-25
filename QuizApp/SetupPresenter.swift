import Foundation

protocol SetupPresenterProtocol: AnyObject {
    init(view: SetupViewProtocol)
    func getCategoriesList() -> [String]
    func getSettings() -> (difficulty: String, category: String)
}

class SetupPresenter: SetupPresenterProtocol {
    let view: SetupViewProtocol
    var difficulty: String
    var category: String

    required init(view: SetupViewProtocol) {
        self.view = view
        self.difficulty = ""
        self.category = ""
    }
    
    func getCategoriesList() -> [String] {
        return Categories.categoriesList
    }
    
    func getSettings() -> (difficulty: String, category: String){
        difficulty = Difficulties.difficultyDictionary[view.getDifficultyLevel()]!
        category = Categories.categoriesDictionary[view.getSelectedCategory()]!
        return (difficulty, category)
    }
}

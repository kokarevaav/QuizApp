import Foundation

protocol ResultsPresenterProtocol: AnyObject {
    init(points: Int, amount: Int, category: TriviaCategory)
    func getCongratsString() -> String
    func getPointsString() -> String
}

class ResultsPresenter: ResultsPresenterProtocol {
    let points: Int
    let amount: Int
    let category: TriviaCategory
    
    required init(points: Int, amount: Int, category: TriviaCategory) {
        self.points = points
        self.amount = amount
        self.category = TriviaCategory(id: 9, name: "General Knowledge")
    }
    
    func getCongratsString() -> String {
        let p = (Double(points)/Double(amount))
        print(p)
        return p < 0.5 ? "Let's try again! You will succeed!" : "Congratulations! You are a \(category.name) expert!"
    }
    
    func getPointsString() -> String {
        return "Your result: \(points)/\(amount)"
    }
}

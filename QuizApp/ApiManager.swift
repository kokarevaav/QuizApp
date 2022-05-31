import Foundation

class ApiManager {
    
    static let apiManager = ApiManager()
    
    func getQuestions(category : TriviaCategory, difficulty: String, completion : @escaping ([Result]) -> Void) {
        let amount = AmountOfQuestions.amountDictionary[difficulty]!
        let request = ApiType.getQuestions(amount: amount, category: String(category.id), difficulty: difficulty).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let questions = try? JSONDecoder().decode(Questions.self, from: data) {
                completion(questions.results!)
            } else {
                completion([])
            }
        }
        task.resume()
    }
    
    func getCategories(completion : @escaping ([TriviaCategory]) -> Void) {
        let request = ApiType.getCategories.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let categories = try? JSONDecoder().decode(CategoriesInfo.self, from: data) {
                completion(categories.triviaCategories!)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}

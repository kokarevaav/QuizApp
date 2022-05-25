import Foundation

class ApiManager {
    
    static let apiManager = ApiManager()
    
    func getQuestions(category : String, difficulty: String, completion : @escaping ([Result]) -> Void) {
        let amount = AmountOfQuestions.amountDictionary[difficulty]!
        let request = ApiType.getQuestions(amount: amount, category: category, difficulty: difficulty).request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let questions = try? JSONDecoder().decode(Questions.self, from: data) {
                completion(questions.results!)
            } else {
                completion([])
            }
        }
        task.resume()
    }
}

import Foundation

enum ApiType {
    var baseUrl : String {
        return "https://opentdb.com"
    }
    
    case getQuestions(amount: String, category: String, difficulty: String)
    
    var headers : [String:String] {
        return [:]
    }
    
    var path : String {
        switch self {
        case .getQuestions(let amount, let category, let difficulty):
            return "/api.php?amount=\(amount)&category=\(category)&difficulty=\(difficulty)"
        }
    }
    
    var request : URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseUrl)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
}

class ApiManager {
    
    static let apiManager = ApiManager()
    
    func getQuestions(category : String, difficulty: String, completion : @escaping ([Result]) -> Void) {
        let request = ApiType.getQuestions(amount: "1", category: category, difficulty: difficulty).request
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

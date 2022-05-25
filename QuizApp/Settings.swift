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

struct Categories {
    static let categoriesDictionary: [String : String] = ["General Knowledge" : "9",
                                                          "Films" : "11",
                                                          "History" : "23",
                                                          "Geography" : "22",
                                                          "Animals" : "27",
                                                          "Music" : "12",
                                                          "Books" : "10",
                                                          "Art" : "25"]
    static let categoriesList = ["General Knowledge",
                                 "Films",
                                 "History",
                                 "Geography",
                                 "Animals",
                                 "Music",
                                 "Books",
                                 "Art"]
}
struct Difficulties {
    static let difficultyDictionary: [Float : String] = [1 : "easy",
                                                         2 : "medium",
                                                         3 : "hard"]
}

struct AmountOfQuestions {
    static let amountDictionary: [String : String] = ["easy" : "15",
                                                      "medium" : "10",
                                                      "hard" : "10"]
}

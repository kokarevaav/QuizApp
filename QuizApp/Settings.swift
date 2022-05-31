import Foundation

enum ApiType {
    var baseUrl : String {
        return "https://opentdb.com"
    }
    
    case getQuestions(amount: String, category: String, difficulty: String)
    case getCategories
    
    var headers : [String:String] {
        return [:]
    }
    
    var path : String {
        switch self {
        case .getQuestions(let amount, let category, let difficulty):
            return "/api.php?amount=\(amount)&category=\(category)&difficulty=\(difficulty)&type=multiple"
        case .getCategories:
            return "/api_category.php"
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

//struct Categories {
//    func getCategories() {
//        ApiManager.apiManager.getCategories() { category in
//            presenter.categories = category.map { category in
//                    var c: TriviaCategory = category
//                    c.name = category.name.replacingOccurrences(of: "Entertainment: ", with: "")
//                    return c
//                }
//        }
//    }
    
//    static var categories: [TriviaCategory] = ApiManager.apiManager.getCategories()
    
    
    
    
    
//map { category in
//    var c: TriviaCategory = category
//    c.name = category.name.replacingOccurrences(of: "Entertainment: ", with: "")
//    return c
//}

//    static let categoriesDictionary: [String : String] = ["9" : "General Knowledge",
//                                                          "Films" : "11",
//                                                          "History" : "23",
//                                                          "Geography" : "22",
//                                                          "Animals" : "27",
//                                                          "Music" : "12",
//                                                          "Books" : "10"]
//    static let categoriesList = ["General Knowledge",
//                                 "Films",
//                                 "History",
//                                 "Geography",
//                                 "Animals",
//                                 "Music",
//                                 "Books"]


struct Difficulties {
    static let difficultyDictionary: [Float : String] = [1 : "easy",
                                                         2 : "medium",
                                                         3 : "hard"]
}

struct AmountOfQuestions {
    static let amountDictionary: [String : String] = ["easy" : "15",
                                                      "medium" : "10",
                                                      "hard" : "3"]
}

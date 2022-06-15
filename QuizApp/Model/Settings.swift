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

struct Difficulties {
    static let difficultyDictionary: [Float : String] = [1 : "easy",
                                                         2 : "medium",
                                                         3 : "hard"]
}

struct AmountOfQuestions {
    static let amountDictionary: [String : String] = ["easy" : "3",
                                                      "medium" : "10",
                                                      "hard" : "10"]
}

extension String {
    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
}

struct NormalQuestions {
    static let normal = NormalQuestions()
    
    func toNormalAnswers(answers: [String]) -> [String] {
        answers.map { answer in
            String(htmlEncodedString: answer)!
        }
    }
    
    func toNormalQuestions(questions: [Result]) -> [Result] {
        let q = questions.map { question -> Result in
            var q = question
            let qString = String(htmlEncodedString: q.question)!
            q.question = qString
            let answersString = String(htmlEncodedString: q.correctAnswer)!
            q.correctAnswer = answersString
            q.incorrectAnswers = self.toNormalAnswers(answers: q.incorrectAnswers)
            return q
        }
        return q
    }
}

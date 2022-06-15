import Foundation

// MARK: - Categories
struct CategoriesInfo: Codable {
    let triviaCategories: [TriviaCategory]?

    enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}

// MARK: - TriviaCategory
struct TriviaCategory: Codable {
    let id: Int
    var name: String
}

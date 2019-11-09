import Foundation

struct Word: Decodable {
    let word: String
    let translation: String
    
    enum CodingKeys: String, CodingKey {
        case word = "text_eng"
        case translation = "text_spa"
    }
}

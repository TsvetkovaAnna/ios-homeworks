
import Foundation

struct News: Decodable {
    
    struct Article: Decodable {
        let author, image, description: String
        let likes: Int
        let views: Int

        enum CodingKeys: String, CodingKey {
            case author, image, description, likes, views
        }
    }

    let articles: [Article]
}


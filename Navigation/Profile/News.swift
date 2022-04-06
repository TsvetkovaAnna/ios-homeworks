
import Foundation

//extension String {
//
//    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        dateFormatter.calendar = Calendar(identifier: .gregorian)
//        dateFormatter.dateFormat = format
//        let date = dateFormatter.date(from: self)
//        return date
//    }
//}


struct News: Decodable {

//    static let dateFormatter: DateFormatter = {
//        let df = DateFormatter()
//        df.dateFormat = "MMMM d, yyyy"
//        df.locale = Locale(identifier: "en_EN")
//        return df
//    }()
    
    struct Article: Decodable {
        let author, image, description: String
        let likes: Int
        let views: Int

//        var publishedAtString: String {
//            return News.dateFormatter.string(from: self.publishedAt.toDate() ?? Date())
//        }

        enum CodingKeys: String, CodingKey {
            case author, image, description, likes, views
        }
    }

    let articles: [Article]
}


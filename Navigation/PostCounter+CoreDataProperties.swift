
import Foundation
import CoreData


extension PostCounter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCounter> {
        return NSFetchRequest<PostCounter>(entityName: "PostCounter")
    }

    @NSManaged public var likes: Int32
    @NSManaged public var views: Int32
    @NSManaged public var photoID: String?

}

extension PostCounter : Identifiable {

}

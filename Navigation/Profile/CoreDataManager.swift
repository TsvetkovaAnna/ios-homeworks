
import UIKit
import CoreData

final class CoreDataManager {
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    var postsCount: Int {
        let fetchRequest = PostCounter.fetchRequest()
        guard let results = try? context.fetch(fetchRequest) else { return 0 }
        return results.count
    }
    
    var isPostsExist: Bool {
        let fetchRequest = PostCounter.fetchRequest()
        guard let results = try? context.fetch(fetchRequest) else { return false }
        return !results.isEmpty
    }
    
    func getAllPosts() -> [PostCounter]? {
        let fetchRequest = PostCounter.fetchRequest()
        return try? context.fetch(fetchRequest)
    }
    
    func createNewPost(post: News.Article) {
        print(#function)
        let newPost = PostCounter(context: context)
        newPost.photoID = post.image
        newPost.likes = Int32(post.likes)
        newPost.views = Int32(post.views)
        appDelegate.saveContext()
    }
    
    private func fetchPost(post: ViewModel) -> PostCounter? {
        print(#function)
        guard let allPosts = getAllPosts() else { return nil }
        return allPosts.first { $0.photoID == post.image }
    }
    
    /*private func fetchPost(post: ViewModel) -> PostCounter? {
        print(#function)
        let fetchRequest = PostCounter.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "photoID = \(post.image)")
        guard let results = try? context.fetch(fetchRequest), let result = results.first else { return nil }
        return result
    }*/
    
    func showLikesInPost(post: ViewModel) -> Int? {
        print(#function)
        guard let currentPost = fetchPost(post: post) else { return nil }
        return Int(currentPost.likes)
    }
    
    func showViewsInPost(post: ViewModel) -> Int? {
        print(#function)
        guard let currentPost = fetchPost(post: post) else { return nil }
        return Int(currentPost.views)
    }
    
    func addLikeToPost(post: ViewModel) {
        print(#function)
        guard let currentPost = fetchPost(post: post) else { return }
        currentPost.likes += 1
        appDelegate.saveContext()
    }
    
    func addViewsToPost(post: ViewModel) {
        print(#function)
        guard let currentPost = fetchPost(post: post) else { return }
        currentPost.views += 1
        appDelegate.saveContext()
    }
}

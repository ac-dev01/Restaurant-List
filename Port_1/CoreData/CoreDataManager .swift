//
//  CoreDataManager .swift
//  Port_1
//
//  Created by Ayush Chaurasia on 14/03/22.
//

import Foundation
import CoreData

//MARK: typealias
typealias RestaurantPhoto = Photo


//MARK: Struct
struct CoreDataManager {
    
    
    let container: NSPersistentContainer
    
    init() {
        
        container = NSPersistentContainer(name: "LetsEatModel")
        container.loadPersistentStores { (storeDescription, error) in
            error.map {
                print($0)
            }
        }
    }
    
    func addReview(_ reviewItem: ReviewItem) {
        
        let review = Review(context: container.viewContext)
        review.date = Date()
        if let reviewItemRating = reviewItem.rating {
            review.rating = reviewItemRating
        }
        review.title = reviewItem.title
        review.name = reviewItem.name
        review.customerReview = reviewItem.customerReview
        if let reviewItemRestaurantID = reviewItem.restaurantID {
            review.restaurantID = reviewItemRestaurantID
        }
        review.uuid = reviewItem.uuid
        save()
    }
    
    func addPhoto(_ restaurantPhotoItem: Photo) {
        
        let restPhoto = RestaurantPhoto(context: container.viewContext)
        restPhoto.date = Date()
        restPhoto.photoData = restaurantPhotoItem.photoData
        
        
//        if let restPhotoID = restaurantPhotoItem.restaurantID {
//            restPhoto.restaurantID = restPhotoID
//        }
        
        restPhoto.restaurantID = restaurantPhotoItem.restaurantID
        
        
        restPhoto.uuid = restaurantPhotoItem.uuid
        save()
    }
    
   private func save() {
        
       do {
           if container.viewContext.hasChanges {
               try container.viewContext.save()
           }
       } catch let error {
           print(error.localizedDescription)
       }
    }
    
     func fetchReviews(by identifier: Int) -> [ReviewItem] {
        
        let moc = container.viewContext
        let request = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", identifier)
        
        var reviewItems: [ReviewItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for review in try moc.fetch(request) {
                reviewItems.append(ReviewItem(review: review))
            }
            
            return reviewItems
        } catch {
            fatalError("Failed to fetch Reviews: \(error)")
        }
    }
    
     func fetchRestPhoto(by identifier: Int) -> [RestaurantPhotoItem] {
        
        let moc = container.viewContext
        let request = RestaurantPhoto.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %1", identifier)
        
        var restPhotoItems: [RestaurantPhotoItem] = []
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        
        do {
            for restPhoto in try moc.fetch(request) {
                restPhotoItems.append(RestaurantPhotoItem(restaurantPhoto: restPhoto))
            }
            
            return restPhotoItems
        } catch {
            fatalError("Failed to fetch restaurant photos: \(error)")
        }
    }
    
    func fetchRestaurantRating(by identifier: Int) -> Double {
        let reviewItems = fetchReviews(by: identifier)
        let sum = reviewItems.reduce(0, { $0 + ($1.rating ?? 0)})
        return sum / Double(reviewItems.count)
    }
}

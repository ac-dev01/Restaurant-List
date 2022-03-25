//
//  Review+CoreDataProperties.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 16/03/22.
//
//

import Foundation
import CoreData


extension Review {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Review> {
        return NSFetchRequest<Review>(entityName: "Review")
    }

    @NSManaged public var customerReview: String?
    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var restaurantID: Int64
    @NSManaged public var title: String?
    @NSManaged public var uuid: UUID?

}

extension Review : Identifiable {

}

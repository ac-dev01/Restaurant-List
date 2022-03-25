//
//  Photo+CoreDataProperties.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 16/03/22.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var date: Date?
    @NSManaged public var photoData: Data?
    @NSManaged public var restaurantID: Int64
    @NSManaged public var uuid: UUID?

}

extension Photo : Identifiable {

}

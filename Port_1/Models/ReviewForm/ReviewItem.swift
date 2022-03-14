//
//  ReviewItem.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 14/03/22.
//

import Foundation


struct ReviewItem {
    
    
    var title: String?
    var date: Date?
    var rating: Double?
    var name: String?
    var customerReview: String?
    var restaurantID: Int64?
    var uuid = UUID()
    
    
}


extension ReviewItem {
    
    init(review: Review)  {
        self.date = review.date
        self.rating = review.rating
        self.title = review.title
        self.name = review.name
        self.customerReview = review.customerReview
        self.restaurantID = review.restaurantID
        
        if let reviewUUID = review.uuid {
            self.uuid = reviewUUID
        }
    }
}


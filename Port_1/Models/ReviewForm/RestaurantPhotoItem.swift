//
//  RestaurantPhotoItem.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 14/03/22.
//

import Foundation
import UIKit


struct RestaurantPhotoItem {
    
    var date: Date?
    var photo: UIImage?
    var photoData: Data {
        guard let photo = photo,
              let photoData = photo.pngData() else {
                  return Data()
              }
        return photoData
    }
    
    var restaurantID: Int64?
    var uuid = UUID()
}



extension RestaurantPhotoItem {
    
    init(restaurantPhoto: Photo) {
        self.date = restaurantPhoto.date
        
        if let restPhoto = restaurantPhoto.photoData {
            self.photo = UIImage(data: restPhoto, scale: 1.0)
        }
        
        self.restaurantID = restaurantPhoto.restaurantID
        
        if let restPhotoUUID = restaurantPhoto.uuid {
            self.uuid = restPhotoUUID
        }
    }
}

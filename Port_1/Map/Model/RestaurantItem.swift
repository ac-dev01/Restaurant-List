//
//  RestaurantItem.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 01/02/22.
//

import Foundation
import MapKit


class RestaurantItem: NSObject, MKAnnotation, Decodable {
   
    let name: String?
    let cuisines: [String]
    let lat: Double?
    let long: Double?
    let address: String?
    let postalCode: String?
    let state: String?
    let imageURL: String?
    let restaurantID: Int?
    

    enum CodkingKeys: String, CodingKey {
        
        case name
        case cuisines
        case lat
        case long
        case address
        case postalCode = "postal_code"
        case state
        case imageURL = "image_url"
        case restaurantID = "id"
        
    }
    
//    init(dict: [String: AnyObject]) {
//
//        self.lat = dict["lat"] as? Double
//        self.long = dict["long"] as? Double
//        self.name = dict["name"] as? String
//        self.cuisines = dict["cuisines"] as? [String] ?? []
//        self.address = dict["address"] as? String
//        self.postalCode = dict["postal_code"] as? String
//        self.state = dict["state"] as? String
//        self.imageURL = dict["image_url"] as? String
//        self.restaurantID = dict["id"] as? Int
//
//    }
//
    var coordinate: CLLocationCoordinate2D {
        
        guard let lat = lat, let long = long else {
            return CLLocationCoordinate2D()
        }
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String? {
        return name
    }
    
    var subtitle: String? {
        if cuisines.isEmpty {
            return ""
        } else if cuisines.count == 1 {
            return cuisines.first
        } else {
            return cuisines.joined(separator: ", ")
        }
    }
}



//
//  MapDataManager .swift
//  Port_1
//
//  Created by Ayush Chaurasia on 01/02/22.
//

import Foundation
import MapKit


class MapDataManager: DataManager {

    private var items: [RestaurantItem] = []
    
    var annotations: [RestaurantItem] {
        items
    }
    
//    private func loadData() -> [[String: AnyObject]] {
//
//        guard let path = Bundle.main.path(forResource: "MapLocations", ofType: "plist"),
//              let itemData = FileManager.default.contents(atPath: path),
//              let items = try! PropertyListSerialization.propertyList(from: itemData,
//                                                                      format: nil) as? [[String: AnyObject]] else {
//                  return [[:]]
//              }
//        return items
//    }
    
    func fetch(completion: (_ annotations: [RestaurantItem]) -> ()) {
//        if !items.isEmpty {
//            items.removeAll()
//        }
//
//        for data in loadPlist(file: "MapLocations") {
//            items.append(RestaurantItem(dict: data))
//        }
//
//        completion(items)
        
        let manager = RestaurantDataManager()
        manager.fetch(location: "Boston") { (restaurantItems) in
            self.items = restaurantItems
            completion(items)
        }
    }
    
    func initialRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        
        guard let item = items.first else { return MKCoordinateRegion() }
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta,
                                    longitudeDelta: longDelta)
        
        return MKCoordinateRegion(center: item.coordinate,
                                  span: span)
        
    }
    
}

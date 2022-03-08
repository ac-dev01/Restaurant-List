//
//  LocationDataManager.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 29/01/22.
//

import Foundation


class LocationDataManager {
    
    private var locations: [LocationItems] = []
    
    private func loadData() -> [[String: String]] {
        
        let decoder = PropertyListDecoder()
        
        if let path = Bundle.main.path(forResource: "Locations", ofType: "plist"),
           let locationData = FileManager.default.contents(atPath: path),
           let locations = try? decoder.decode([[String: String]].self, from: locationData) {
            return locations
        }
        
        return [[:]]
    }
    
    func fetch() {
        for location in loadData() {
            
            locations.append(LocationItems(dict: location))
            
        }
    }
    
    
    func numberOfSections() -> Int {
        return locations.count
    }
    
    func locationItem(at index: Int) -> LocationItems {
        return locations[index]
    }
}


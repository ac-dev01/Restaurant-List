//
//  ExploreManager.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 27/01/22.
//

import Foundation


class ExploreDataManager: DataManager {
    
    private var exploreItems: [ExploreItem] = []
    
//    private func loadData() -> [[String: String]] {
//
//        let decoder = PropertyListDecoder()
//
//        if let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
//           let exploreData = FileManager.default.contents(atPath: path),
//           let exploreItem = try? decoder.decode([[String: String]].self, from: exploreData) {
//            return exploreItem
//        }
//
//        return [[:]]
//    }
    
    func fetch() {
        for data in loadPlist(file: "ExploreData") {
            exploreItems.append(ExploreItem(dict: data as! [String: String]))
        }
    }
    
    func numberOfExploreItems() -> Int {
        exploreItems.count
    }
    
    func exploreItem(at index: Int) -> ExploreItem {
        exploreItems[index]
    }
}

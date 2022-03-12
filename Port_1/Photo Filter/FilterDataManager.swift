//
//  FilterDataManager.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 11/03/22.
//

import Foundation


struct FilterDataManager: DataManager {
    
    func fetch() -> [FilterItem] {
        
        var filterItems: [FilterItem] = []
        
        for data in loadPlist(file: "FilterData") {
            
            filterItems.append(FilterItem(dict: data as! [String: String]))
            
        }
        return filterItems
    }
}


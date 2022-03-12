//
//  FilterItem.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 11/03/22.
//

import Foundation


struct FilterItem {
    
    let filter: String?
    let name: String?
    
    init(dict: [String: String]) {
        self.filter = dict["filter"]
        self.name = dict["name"]
    }
    
}

//
//  LocationItems.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 17/02/22.
//

import Foundation
import UIKit


struct LocationItems: Equatable {
    let city: String?
    let state: String?
}

extension LocationItems {
    
    init(dict: [String: String]) {
        self.city = dict["city"]
        self.state = dict["state"]
    }
    
    var cityAndState: String {
        guard let city = self.city,
              let state = self.state else {
                  return ""
              }
        return "\(city), \(state)"
    }
    
}

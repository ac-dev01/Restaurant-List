//
//  Device.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 26/03/22.
//

import Foundation
import UIKit


enum Device {
    
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
}

//
//  RestaurantDetailViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 04/02/22.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {

    //MARK: Properties
    
    var selectedRestaurant: RestaurantItem?
    
    //MARK: IBOutlets, IBActions
    
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(selectedRestaurant as Any)

    }
    
    
    //MARK: HelperMethods

}

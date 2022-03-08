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
    
        //NAV BAR
    @IBOutlet var heartButton: UIBarButtonItem!
    
        //Cell One
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cuisineLabel: UILabel!
    @IBOutlet var headerAddressLabel: UILabel!
    
    
        //Cell Two
    @IBOutlet var tableDetailLabel: UILabel!
    
        //Cell Three
    @IBOutlet var overallRatingLabel: UILabel!
    
        //Cell Eight
    @IBOutlet var addressLabel: UILabel!
    
        //Cell Nine
    @IBOutlet var locationMapImageView: UIImageView!
    
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(selectedRestaurant as Any)

    }
    
    
    //MARK: HelperMethods

}

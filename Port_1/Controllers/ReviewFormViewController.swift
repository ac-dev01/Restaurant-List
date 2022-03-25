//
//  ReviewFormViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 11/03/22.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    //MARK: Properties
    
    var selectedRestaurantID: Int?
    
    //MARK: IBOutlets , IBActions
    
    @IBOutlet var ratingsView: RatingsView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var reviewTextView: UITextView!
    
    @IBAction func onSaveTapped(_ sender: Any) {
        
        var reviewItem = ReviewItem()
        reviewItem.rating = ratingsView.rating
        reviewItem.title = titleTextField.text
        reviewItem.name = nameTextField.text
        reviewItem.customerReview = reviewTextView.text
        
        if let selRestID = selectedRestaurantID {
            reviewItem.restaurantID = Int64(selRestID)
        }
        
        CoreDataManager.shared.addReview(reviewItem)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //MARK: View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurantID as Any)
    }
    
    
}


//MARK: Datasource and Delegates
extension ReviewFormViewController {
    
}

//MARK: Helper Methods

private extension ReviewFormViewController {
    
    
    
}

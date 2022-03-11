//
//  ReviewFormViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 11/03/22.
//

import UIKit

class ReviewFormViewController: UITableViewController {

    //MARK: Properties
    
    
    //MARK: IBOutlets , IBActions
    
    @IBOutlet var ratingsView: RatingsView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var reviewTextView: UITextView!
    
    
    @IBAction func onSaveTapped(_ sender: Any) {
        
        print(ratingsView.rating)
        print(titleTextField.text as Any)
        print(nameTextField.text as Any)
        print(reviewTextView.text as Any)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //MARK: View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}


//MARK: Datasource and Delegates
extension ReviewFormViewController {
    
}

//MARK: Helper Methods

private extension ReviewFormViewController {
    
    
    
}

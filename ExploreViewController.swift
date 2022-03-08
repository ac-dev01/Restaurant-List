//
//  ExploreViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 20/01/22.
//

import Foundation
import UIKit



class ExploreViewController: UIViewController {
    
    
    //MARK: Properties
    
    static let cellIdentifier = "ExploreCell"
    static let sectionHeaderIdentifier = "header"
    
    let manager = ExploreDataManager()
    var selectedCity: LocationItems?
    var headerView: ExploreHeaderView!

    
    //MARK: IBOutlets, IBActions
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    //MARK: Methods
    override func viewDidLoad() {
       initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case Segue.locationList.rawValue:
            showLocationList(segue: segue)
            
        case Segue.restaurantList.rawValue:
            showRestaurant(segue: segue)
            
        default:
            print("Segue not added")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue,
           selectedCity == nil {
            showLocationRequireAlert()
            return false
        }
        return true
    }
}



//MARK: UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfExploreItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreViewController.cellIdentifier, for: indexPath) as! ExploreCell
        
        let exploreItem = manager.exploreItem(at: indexPath.row)
        cell.exploreNameLabel.text = exploreItem.name
        cell.exploreImageView.image = UIImage(named: exploreItem.image!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ExploreViewController.sectionHeaderIdentifier,
                                                                     for: indexPath)
        
        headerView = header as? ExploreHeaderView
        
        return headerView
        
    }
}


//MARK: Private Extension
private extension ExploreViewController  {
    
    @IBAction func unwindLoactionCancel(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue) {
        
        if let viewController = segue.source as? LocationViewController {
            selectedCity = viewController.selectedCity
            
            if let location = selectedCity {
                headerView.locationLabel.text = location.cityAndState
            }
        }
    }
    
    
    func initialize() {
        manager.fetch()
    }
    
    func showLocationList(segue: UIStoryboardSegue) {
        
        guard let navController = segue.destination as? UINavigationController,
              let viewController = navController.topViewController as? LocationViewController else {
                  return
              }
        viewController.selectedCity = selectedCity
    }
    
    func showRestaurant(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantListViewController,
           let city = selectedCity,
           let index = collectionView.indexPathsForSelectedItems?.first?.row {
            viewController.selectedCuisine = manager.exploreItem(at: index).name
            viewController.selectedCity = city
        }
    }
    
    func showLocationRequireAlert() {
        let alertController = UIAlertController(title: "Location Needed",
                                                message: "Please select a Location",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        present(alertController,
                animated: true,
                completion: nil)
    }
}

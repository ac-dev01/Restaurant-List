//
//  RestaurantListViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 23/01/22.
//

import UIKit

class RestaurantListViewController: UIViewController {
    
    
    //MARK: Properties
    
    static let restaurantCellIdentifier = "restaurantCell"
    
    private let manager = RestaurantDataManager()
    
    var selectedRestaurant: RestaurantItem?
    var selectedCity: LocationItems?
    var selectedCuisine: String?
    
    
    
    
    //MARK: IBActions, IBOutlets
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    //MARK: Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createData()
        setupTitle()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showDetail.rawValue:
                showRestaurantDetail(segue: segue)
                
            default:
                print("Segue not added")
            }
        }
        
    }
    
}

private extension RestaurantListViewController {
    
    func createData() {
        guard let city = selectedCity?.city,
              let cuisine = selectedCuisine else {
                  return
              }
        
        manager.fetch(location: city, selectedCuisine: cuisine) { restaurantItems in
            if !restaurantItems.isEmpty {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: collectionView.frame.width,
                                                    height: collectionView.frame.height))
                
                view.set(title: "Restaurants",
                         desc: "No restaurants found.")
                
                collectionView.backgroundView = view
            }
            
            collectionView.reloadData()
        }
    }
    
    func setupTitle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = selectedCity?.cityAndState.uppercased()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showRestaurantDetail(segue: UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailViewController,
           let indexPath = collectionView.indexPathsForSelectedItems?.first {
            selectedRestaurant = manager.restaurantItem(at: indexPath.row)
            viewController.selectedRestaurant = selectedRestaurant
        }
    }
}



//MARK: UICollectionViewDataSource
extension RestaurantListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        manager.numberOfRestaurantItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        
        let restaurantItem = manager.restaurantItem(at: indexPath.row)
        
        cell.titleLabel.text = restaurantItem.name
        
        if let cuisine = restaurantItem.subtitle {
            cell.cuisineLabel.text = cuisine
        }
        
        if let imageURL = restaurantItem.imageURL {
            if let url = URL(string: imageURL) {
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.restaurantImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        return cell
    }
}

//
//  ReviewViewController.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 25/03/22.
//

import UIKit

class ReviewViewController: UIViewController {
    
    
    //MARK: Properties
    var selectedRestaurantID: Int?
    private var reviewItems: [ReviewItem] = []
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()

    
    // MARK: IBOutlet, IBAction
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    // MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}


private extension ReviewViewController {
    
    func initlize() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
     let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flow
    }
    
    func checkReviews() {
        let viewController = self.parent as? RestaurantDetailViewController
        if let restaurantID = viewController?.selectedRestaurant?.restaurantID {
            reviewItems = CoreDataManager.shared.fetchReviews(by: restaurantID)
            
            if !reviewItems.isEmpty {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews",
                         desc: "There are currently no reviews")
                collectionView.backgroundView = view
            }
        }
        collectionView.reloadData()
    }
}

extension ReviewViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        
        let reviewItem = reviewItems[indexPath.item]
        cell.nameLabel.text = reviewItem.name
        cell.titleLabel.text = reviewItem.title
        cell.reviewLabel.text = reviewItem.customerReview
        
        if let reviewItemDate = reviewItem.date {
            cell.dateLabel.text = dateFormatter.string(from: reviewItemDate)
        }
        
        if let reviewItemRating = reviewItem.rating {
            cell.ratingsView.rating = reviewItemRating
        }
        
        return cell
    }
}


extension ReviewViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInset = 7.0
        
        if reviewItems.count == 1 {
            let cellWidth = collectionView.frame.size.width - (edgeInset * 2)
            return CGSize(width: cellWidth, height: 200)
        } else {
            let cellWidth = collectionView.frame.size.width - (edgeInset * 3)
            return CGSize(width: cellWidth, height: 200)
        }
    }
}

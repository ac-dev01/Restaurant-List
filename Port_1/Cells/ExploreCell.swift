//
//  ExploreCell.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 29/01/22.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    //MARK: Properties
    
    
    //MARK: IBActions, IBOutlets
    
    
    @IBOutlet var exploreNameLabel: UILabel!
    @IBOutlet var exploreImageView: UIImageView!
    
    
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//
//
//    }
    
    override func layoutSubviews() {
        exploreImageView.layer.cornerRadius = 10
        exploreImageView.layer.masksToBounds = true
    }
}

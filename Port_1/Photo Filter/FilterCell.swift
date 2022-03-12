//
//  FilterCell.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 12/03/22.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    //MARK: Properties
    
    
    
    //MARK: IBOutlets, IBActions
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    
    
    //MARK: ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = 9
        thumbnailImageView.layer.masksToBounds = true
    }
}


extension FilterCell: ImageFiltering {
    
    func set(filterItem: FilterItem, imageForThumbnail: UIImage) {
        
        nameLabel.text = filterItem.name
        
        if let filter = filterItem.filter {
            if filter != "None" {
                let filteredImage = apply(filter: filter,
                                          originalImage: imageForThumbnail)
                
                thumbnailImageView.image = filteredImage
            } else {
                thumbnailImageView.image = imageForThumbnail
            }
        }
    }
}

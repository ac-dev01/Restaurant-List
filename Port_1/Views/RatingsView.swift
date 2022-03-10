//
//  RatingsView.swift
//  Port_1
//
//  Created by Ayush Chaurasia on 11/03/22.
//

import UIKit

class RatingsView: UIControl {

    
    //MARK: Properties
    
    private let filledStarImage = UIImage(named: "filled-star")
    private let halfStarImage = UIImage(named: "half-star")
    private let emptyStarImage = UIImage(named: "empty-star")
    
    private var totalStars = 5
    var rating = 0.0
    

    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.systemBackground.cgColor)
        context!.fill(rect)
        
        let ratingViewsWidth = rect.size.width
        let availableWidthForStar = ratingViewsWidth / Double(totalStars)
        
        let starSideLength = (availableWidthForStar <= rect.size.height) ? availableWidthForStar : rect.size.height
        
        for index in 0..<totalStars {
            
            let starOriginX = (availableWidthForStar * Double(index)) + ((availableWidthForStar - starSideLength) / 2)
            let starOriginY = ((rect.size.height - starSideLength) / 2)
            
            let frame = CGRect(x: starOriginX,
                               y: starOriginY,
                               width: starSideLength,
                               height: starSideLength)
            
            var starToDraw: UIImage!
            
            if (Double(index + 1) <= self.rating) {
                starToDraw = filledStarImage
            } else if (Double(index + 1) <= self.rating.rounded()) {
                starToDraw = halfStarImage
            } else {
                starToDraw = emptyStarImage
            }
            
            starToDraw.draw(in: frame)
        }
    }
}

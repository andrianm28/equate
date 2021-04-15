//
//  CategoryCollectionViewCell.swift
//  equate
//
//  Created by Rostadhi Akbar, M.Pd on 11/04/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
  
    func setup(with category: Category)  {
        categoryImage.image = category.Image
        categoryLabel.text = category.title
    }
}

struct Category {
    let title  : String
    let Image : UIImage
    let value: String
    
}

let categories: [Category] = [
    Category(title: "Productivity", Image: #imageLiteral(resourceName: "productivity"), value:"Productivity"),
    Category(title: "Rest and Sleep", Image: #imageLiteral(resourceName: "restsleep"), value:"Rest and Sleep"),
    Category(title: "Social", Image: #imageLiteral(resourceName: "social"), value:"Social"),
    Category(title: "Leisure", Image: #imageLiteral(resourceName: "leisure"), value:"Leisure Time")
]


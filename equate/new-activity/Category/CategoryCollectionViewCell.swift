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
    
}

let categories: [Category] = [
    Category(title: "Productivity", Image: #imageLiteral(resourceName: "productivity")),
    Category(title: "Rest&Sleep", Image: #imageLiteral(resourceName: "restsleep")),
    Category(title: "Social", Image: #imageLiteral(resourceName: "social")),
    Category(title: "Leisure", Image: #imageLiteral(resourceName: "leisure"))
]


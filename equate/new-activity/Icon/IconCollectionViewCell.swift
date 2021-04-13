//
//  IconCollectionViewCell.swift
//  equate
//
//  Created by Rostadhi Akbar, M.Pd on 11/04/21.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var IconImage: UIImageView!
    
    func setup(with icon: Icon) {
        IconImage.image = icon.image
        
    }
}

struct Icon {
    let title: String
    let image: UIImage
    
}

let icons: [Icon] = [
    Icon(title: "Productivity", image: #imageLiteral(resourceName: "running")),
    Icon(title: "", image: #imageLiteral(resourceName: "open-book")),
    Icon(title: "", image: #imageLiteral(resourceName: "chef")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "", image: #imageLiteral(resourceName: "bowling-pins")),
    Icon(title: "", image: #imageLiteral(resourceName: "leisure-2")),
    Icon(title: "Social", image: #imageLiteral(resourceName: "businessmen")),
    Icon(title: "", image: #imageLiteral(resourceName: "phone-call")),
    Icon(title: "", image: #imageLiteral(resourceName: "breakfast-tray")),
    Icon(title: "Rest & Sleep", image: #imageLiteral(resourceName: "moon")),
    Icon(title: "", image: #imageLiteral(resourceName: "heart")),
    Icon(title: "", image: #imageLiteral(resourceName: "rest"))
]

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
    let index: String
    let image: UIImage
    
}

let icons: [Icon] = [
    Icon(index: "0" , image: #imageLiteral(resourceName: "running")),
    Icon(index: "1", image: #imageLiteral(resourceName: "open-book")),
    Icon(index: "2", image: #imageLiteral(resourceName: "chef")),
    Icon(index: "3", image: #imageLiteral(resourceName: "cocktail")),
    Icon(index: "4", image: #imageLiteral(resourceName: "bowling-pins")),
    Icon(index: "5", image: #imageLiteral(resourceName: "leisure-2")),
    Icon(index: "6", image: #imageLiteral(resourceName: "businessmen")),
    Icon(index: "7", image: #imageLiteral(resourceName: "phone-call")),
    Icon(index: "8", image: #imageLiteral(resourceName: "breakfast-tray")),
    Icon(index: "9", image: #imageLiteral(resourceName: "moon")),
    Icon(index: "10", image: #imageLiteral(resourceName: "heart")),
    Icon(index: "11", image: #imageLiteral(resourceName: "rest"))
]

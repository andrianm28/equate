//
//  IconCollectionViewCell.swift
//  equate
//
//  Created by Rostadhi Akbar, M.Pd on 11/04/21.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var IconLabel: UILabel!
    @IBOutlet weak var IconImage: UIImageView!
    
    func setup(with icon: Icon) {
        IconImage.image = icon.image
        IconLabel.text = icon.title
    }
}

struct Icon {
    let title: String
    let image: UIImage
    
}

let icons: [Icon] = [
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "phone-call")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "breakfast-tray")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail")),
    Icon(title: "Leisure", image: #imageLiteral(resourceName: "cocktail"))
]

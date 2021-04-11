//
//  IconViewController.swift
//  equate
//
//  Created by Rostadhi Akbar, M.Pd on 11/04/21.
//

import UIKit

class IconViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{


    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCellIdetifier", for: indexPath) as! IconCollectionViewCell
        return cell
        
    }
    

}

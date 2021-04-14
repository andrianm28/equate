//
//  CategoryViewController.swift
//  equate
//
//  Created by Rostadhi Akbar, M.Pd on 11/04/21.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var delegate: isAbleToReceiveData!
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    @IBAction func cellTapped(_ sender: UIButton) {
        print(sender.currentTitle!)
        dismiss(animated: true, completion: nil)
        delegate.pass(data: sender.currentTitle!)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellIdentifier", for: indexPath) as! CategoryCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        
        
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = UIColor.white
        
        let editButton = UIButton(frame: CGRect(x:0, y:20, width:184,height:247))
        editButton.addTarget(self, action: #selector(cellTapped), for: UIControl.Event.touchUpInside)
        editButton.setTitle(categories[indexPath.row].value, for: .normal)
        editButton.setTitleColor(UIColor.clear, for: .normal)

        cell.setup(with: categories[indexPath.row])
        cell.addSubview(editButton)
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
        return CGSize(width: 171, height: 234)
    }
}

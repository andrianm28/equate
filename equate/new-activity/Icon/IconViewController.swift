//
//  IconViewController.swift
//  equate
//
//  Created by Rostadhi Akbar, M.Pd on 11/04/21.
//

import UIKit

class IconViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    var delegate: isAbleToReceiveData!


    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(IconCollectionViewCell.self, forCellWithReuseIdentifier: "IconCellIdetifier")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    @IBAction func cellTapped(_ sender: UIButton) {
        let icIndex = Int(sender.currentTitle!) ?? 0
//        print(icons[icIndex].image)
        dismiss(animated: true, completion: nil)
        delegate.passIcon(icon: icons[icIndex].image)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1.0
        
        
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = UIColor.white
        
//        set button
        let editButton = UIButton(frame: CGRect(x:0, y:20, width:184,height:247))
        editButton.addTarget(self, action: #selector(cellTapped), for: UIControl.Event.touchUpInside)
        editButton.setTitle(icons[indexPath.row].index, for: .normal)
        editButton.setTitleColor(UIColor.clear, for: .normal)
        
        cell.setup(with: icons[indexPath.row])
        cell.addSubview(editButton)

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 117, height: 133)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.layer.borderWidth = 2
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = UIColor.white.cgColor
        cell?.layer.borderWidth = 03
        
    }
}

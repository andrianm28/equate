//
//  SuggestionViewController.swift
//  equate
//
//  Created by M. Andrian Maulana on 07/04/21.
//

import UIKit

class SuggestionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var catTitle = "Social"
    var catPercentage = 50
    var catColor = "#BAB0F2"
    var catInfo = "No Data Available"
    var catTips = "Average Ideal time for Social is 2 hours / day Add new goal for Social to enhance your work-life-balance!"
    var suggestionIcon: [UIImage] = [
        UIImage(named: "callafriend")!,
        UIImage(named: "coffeewithfriend")!,
        UIImage(named: "surfsocialmedia")!
    ]
    var suggestionTitle = ["Grab Coffe with Friends", "Call a Friend", "Surf Social Media"]
    var suggestionDuration = [30,30,30]
    
    @IBOutlet weak var suggestionSummary: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var tipBodyLabel: UILabel!
    
    @IBOutlet weak var newGoalButton: UIButton!
    
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var textSummaryCV: UIView!
    @IBOutlet weak var circleBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let shapeLayer = CAShapeLayer()
        let trackLayer = CAShapeLayer()
        
        titleLabel.text = catTitle
        percentageLabel.text = "\(catPercentage)%"
        infoLabel.text = catInfo
        
        alertLabel.layer.masksToBounds = true
        alertLabel.layer.cornerRadius = 10
        alertLabel.text = "  ⚠️ \(catInfo)"
        
        tipTitleLabel.text = "Tip for your \(catTitle)"
        tipBodyLabel.text = catTips
    
        newGoalButton.layer.masksToBounds = true
        newGoalButton.layer.cornerRadius = 10
        
        testView.layer.cornerRadius = 10
        circleBar.layer.cornerRadius = 10
        textSummaryCV.layer.cornerRadius = 10
        
        testView.layer.shadowColor = UIColor.gray.cgColor
        testView.layer.shadowOpacity = 1
        testView.layer.shadowOffset = CGSize(width: 0, height: 3)
        testView.layer.shadowRadius = 5
        testView.layer.masksToBounds = false
        
        shapeLayer.frame = circleBar.bounds
        trackLayer.frame = circleBar.bounds
        
        let percentage = catPercentage
        let center = shapeLayer.position
        
        // track layer
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let progressPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: ((CGFloat(percentage)/100) - 0.25) * (2 * CGFloat.pi), clockwise: true)

        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = hexStringToUIColor(hex: catColor).cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 12
        
        // progress layer
        shapeLayer.path = progressPath.cgPath
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        circleBar.layer.addSublayer(trackLayer)
        circleBar.layer.addSublayer(shapeLayer)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCellIdentifier", for: indexPath) as? SuggestionCell
        
        cell?.contentView.layer.cornerRadius = 10
        suggestionSummary.backgroundColor = UIColor.clear
        
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOpacity = 1
        cell?.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell?.layer.shadowRadius = 5
        cell?.layer.masksToBounds = false
        
        cell?.suggestionIconIV.image = suggestionIcon[indexPath.row]
        cell?.suggestionTitleLabel.text = suggestionTitle[indexPath.row]
        cell?.suggestionDurationLabel.text = "\(suggestionDuration[indexPath.row]) minutes / day"
        
        return cell!
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
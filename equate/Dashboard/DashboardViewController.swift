//
//  ViewController.swift
//  equate
//
//  Created by M. Andrian Maulana on 31/03/21.
//

import UIKit

class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var todayGoalView: UITableView!
    @IBOutlet weak var summaryCollection: UICollectionView!
    var dash_title = ["Productivity","Leisure Time","Social","Rest and Sleep"]
    var dash_percent = [80,50,30,75]
    var dash_color = ["#A5B7FE","#F9CDAD","#BAB0F2","#B6F6C1"]
    
    var selectedCell = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shapeLayer = CAShapeLayer()
        let trackLayer = CAShapeLayer()
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "percentCellIdentifier", for: indexPath) as? percentageCell
        
        cell?.contentView.isUserInteractionEnabled = true
        
        cell?.contentView.layer.cornerRadius = 10
        summaryCollection.backgroundColor = UIColor.clear
        
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOpacity = 1
        cell?.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell?.layer.shadowRadius = 5
        cell?.layer.masksToBounds = false

        shapeLayer.frame = cell!.bounds
        trackLayer.frame = cell!.bounds

        let title = dash_title[indexPath.row]
        let percentage = dash_percent[indexPath.row]
        var center = shapeLayer.position
        center.y = center.y - 10
        
        cell?.cellPercent.text = "\(percentage)%"
        cell?.cellTitle.text = title

        //track
        let circularPath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        let progresspath = UIBezierPath(arcCenter: center, radius: 50, startAngle: -CGFloat.pi/2, endAngle: ((CGFloat(percentage)/100) - 0.25) * (2 * CGFloat.pi), clockwise: true)

        trackLayer.path = circularPath.cgPath

        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 15

        //path
        shapeLayer.path = progresspath.cgPath

        shapeLayer.strokeColor = hexStringToUIColor(hex: dash_color[indexPath.row]).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 15

        shapeLayer.lineCap = CAShapeLayerLineCap.round

        cell?.layer.addSublayer(trackLayer)
        cell?.layer.addSublayer(shapeLayer)
        //assign cell title,percent, etc here
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do your stuff with selectedIndex.row as the index
        if segue.identifier == "toSuggestion"  {
            let selectedIndex = summaryCollection.indexPath(for: sender as! UICollectionViewCell)
            let destVC = segue.destination as? SuggestionViewController
            print("\(selectedCell) in suggestion")
            destVC?.catTitle = dash_title[selectedIndex!.row]
            destVC?.catColor = dash_color[selectedIndex!.row]
            destVC?.catPercentage = dash_percent[selectedIndex!.row]
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todayCardIdentifier", for: indexPath) as! todayGoalCard
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.selectedBackgroundView?.layer.cornerRadius = 10
        return cell
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


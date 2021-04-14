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
    
    var suggestedList: [SuggestedGoal] = [
        SuggestedGoal(name: "Read a book", category: "Productivity", icon: UIImage(named: "Group 9"), duration: 60),
        SuggestedGoal(name: "Make a journal", category: "Productivity", icon: UIImage(named: "open-book"), duration: 30),
        SuggestedGoal(name: "Enroll a free course", category: "Productivity", icon: UIImage(named: "Group 9"), duration: 240),
        SuggestedGoal(name: "Learn a new skill", category: "Productivity", icon: UIImage(named: "Group 11"), duration: 240),
        SuggestedGoal(name: "Set up a workout routine", category: "Productivity", icon: UIImage(named: "Group 7"), duration: 60),
        SuggestedGoal(name: "Volunteer", category: "Productivity", icon: UIImage(named: "Group 28"), duration: 360),
        SuggestedGoal(name: "Learn a new language", category: "Productivity", icon: UIImage(named: "Group 9"), duration: 240),
        SuggestedGoal(name: "Watching TV", category: "Leisure Time", icon: UIImage(named: "Group 31"), duration: 60),
        SuggestedGoal(name: "Playing Games", category: "Leisure Time", icon: UIImage(named: "Group 31"), duration: 60),
        SuggestedGoal(name: "Go for a walk", category: "Leisure Time", icon: UIImage(named: "Group 7"), duration: 30),
        SuggestedGoal(name: "Clean house", category: "Leisure Time", icon: UIImage(named: "chef"), duration: 45),
        SuggestedGoal(name: "Listening to music", category: "Leisure Time", icon: UIImage(named: "Group 31"), duration: 60),
        SuggestedGoal(name: "Watching Movies/Series", category: "Leisure Time", icon: UIImage(named: "Group 31"), duration: 240),
        SuggestedGoal(name: "Cycling", category: "Leisure Time", icon: UIImage(named: "Group 7"), duration: 30),
        SuggestedGoal(name: "Karaoke", category: "Social", icon: UIImage(named: "Group 31"), duration: 60),
        SuggestedGoal(name: "Social Media", category: "Social", icon: UIImage(named: "surfsocialmedia-icon"), duration: 30),
        SuggestedGoal(name: "Online Gaming", category: "Social", icon: UIImage(named: "Group 31"), duration: 60),
        SuggestedGoal(name: "Meetup with friends", category: "Social", icon: UIImage(named: "social_icon"), duration: 60),
        SuggestedGoal(name: "Call a friend", category: "Social", icon: UIImage(named: "callafriend-icon"), duration: 30),
        SuggestedGoal(name: "Family Dinner", category: "Social", icon: UIImage(named: "Group 16"), duration: 60),
        SuggestedGoal(name: "Sleep", category: "Rest and Sleep", icon: UIImage(named: "rest"), duration: 480),
        SuggestedGoal(name: "Meditation", category: "Rest and Sleep", icon: UIImage(named: "meditation-pose"), duration: 30)
    ]
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var suggestionSummary: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var tipBodyLabel: UILabel!
    
    @IBOutlet weak var suggestionGoalLabel: UILabel!
    @IBOutlet weak var suggestionDescLabel: UILabel!
    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var textSummaryCV: UIView!
    @IBOutlet weak var circleBar: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)

        // Do any additional setup after loading the view.
        let shapeLayer = CAShapeLayer()
        let trackLayer = CAShapeLayer()
        
        titleLabel.text = catTitle
        percentageLabel.text = "\(catPercentage)%"
        infoLabel.text = catInfo
        
        
        alertLabel.layer.masksToBounds = true
        alertLabel.layer.cornerRadius = 10
        alertLabel.text = "  ⚠️ \(catInfo)"

        var idealTime = 0
        
        switch catTitle {
        case "Productivity":
            idealTime = 6
        case "Leisure Time":
            idealTime = 5
        case "Social":
            idealTime = 6
        case "Rest and Sleep":
            idealTime = 7
        default:
            idealTime = 0
        }
        
        tipTitleLabel.text = "Tip for your \(catTitle)"
        tipBodyLabel.text = "Average Ideal time for \(catTitle) is \(idealTime) hours / day Add new goal for Social to enhance your work-life-balance!"
        
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
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineWidth = 12
        
        // progress layer
        shapeLayer.path = progressPath.cgPath
        shapeLayer.strokeColor = hexStringToUIColor(hex: catColor).cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 12
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        circleBar.layer.addSublayer(trackLayer)
        circleBar.layer.addSublayer(shapeLayer)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestedList.filter{ $0.category.contains(catTitle) }.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestionCellIdentifier", for: indexPath) as? SuggestionCell
        
        cell?.layer.cornerRadius = 10
        suggestionSummary.backgroundColor = UIColor.clear
        
        cell?.layer.shadowColor = UIColor.gray.cgColor
        cell?.layer.shadowOpacity = 1
        cell?.layer.shadowOffset = CGSize(width: 0, height: 3)
        cell?.layer.shadowRadius = 5
        cell?.layer.masksToBounds = false
        
        let suggestedCatlist = suggestedList.filter{ $0.category.contains(catTitle) }
        
        cell?.suggestionIconIV.image = suggestedCatlist[indexPath.row].icon
        cell?.suggestionTitleLabel.text = suggestedCatlist[indexPath.row].name
        if minutesToHoursAndMinutes(suggestedCatlist[indexPath.row].duration).hours != 0 {
            cell?.suggestionDurationLabel.text = "\(minutesToHoursAndMinutes(suggestedCatlist[indexPath.row].duration).hours) hours / day"
        } else {
            cell?.suggestionDurationLabel.text = "\(minutesToHoursAndMinutes(suggestedCatlist[indexPath.row].duration).leftMinutes) minutes / day"
        }
        
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSuggestNewGoal" {
            let selectedIndex = suggestionSummary.indexPath(for: sender as! UICollectionViewCell)
            let destVC = segue.destination as? NewActivityViewController
            
//            destVC?.newGoal.name = suggestionTitle[selectedIndex!.row]
//            destVC?.newGoal.category = catTitle
//            destVC?.newGoal.durationInMinutes = suggestionDuration[selectedIndex!.row]
//            destVC?.newGoal.icon = suggestionIcon[selectedIndex!.row]
        }
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
    
    func minutesToHoursAndMinutes (_ minutes : Int64) -> (hours : Int64 , leftMinutes : Int64) {
        return (minutes / 60, (minutes % 60))
    }
    
    public struct SuggestedGoal {
        var name: String!
        var category: String!
        var icon: UIImage!
        var duration: Int64!
    }

}

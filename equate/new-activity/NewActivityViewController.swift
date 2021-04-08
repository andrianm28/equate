//
//  NewActivityViewController.swift
//  equate
//
//  Created by Alif Mahardhika on 08/04/21.
//

import UIKit

class NewActivityViewController: UIViewController {

    @IBOutlet weak var goalNameButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var repSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chevronArr = [goalNameButton, categoryButton, iconButton]
//        let dayArr = ["Sun", "Mon", "Tue", "Wed","Thu","Fri","Sat"]
        for i in chevronArr{
            setButton(butt: i!)
        }
        // Do any additional setup after loading the view.
    }
    
    func setButton(butt: UIButton){
        let chevron = UIImage(systemName: "chevron.forward")
        chevron?.withTintColor(UIColor.lightGray)
        butt.setImage(chevron, for: .normal)
        butt.setTitle("", for: .normal)
        butt.tintColor = UIColor.lightGray
    }

    @IBAction func tapSetGoal(_ sender: Any) {
//        present(inputGoalController(), animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "inputGoal") as! inputGoalController
        present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class inputGoalController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct activity {
    var name: String!
}

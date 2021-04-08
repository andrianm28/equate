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
//        set every chevron butt
        for i in chevronArr{
            setButton(butt: i!)
        }
    }
    
    func setButton(butt: UIButton){
//        setup chevron button (the '>' thingy)
        let chevron = UIImage(systemName: "chevron.forward")
        chevron?.withTintColor(UIColor.lightGray)
        butt.setImage(chevron, for: .normal)
        butt.setTitle("", for: .normal)
        butt.tintColor = UIColor.lightGray
    }

    @IBAction func tapSetGoal(_ sender: Any) {
//        present(inputGoalController(), animated: true)
        let vc = storyboard?.instantiateViewController(identifier: "inputGoal") as! inputGoalController
//      present new storyboard
        present(vc, animated: true)
    }
//    dismiss storyboard
    @IBAction func backtoDash(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

//    INPUT GOAL NAME CONTROLLER
}
class inputGoalController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func closethisshit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneInput(_ sender: Any) {
//        TODO SAVE INPUT
        dismiss(animated: true, completion: nil)

    }
}

struct activity {
    var name: String!
}

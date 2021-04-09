//
//  NewActivityViewController.swift
//  equate
//
//  Created by Alif Mahardhika on 08/04/21.
//

import UIKit
protocol isAbleToReceiveData {
  func pass(data: String)  //data: string is an example parameter
}

class NewActivityViewController: UIViewController, isAbleToReceiveData {
    
    @IBOutlet weak var goalNameButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var repSwitch: UISwitch!
    @IBOutlet var dayCollection: [UIButton]!
    @IBOutlet weak var acivityNameValue: UILabel!
    var newActivity = Activity(name: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chevronArr = [goalNameButton, categoryButton, iconButton]
//        let dayArr = ["Sun", "Mon", "Tue", "Wed","Thu","Fri","Sat"]
//        set every chevron butt
        for i in chevronArr{
            setButton(butt: i!)
        }
        acivityNameValue.text = self.newActivity.name
    }
    
    func pass(data: String) { //conforms to protocol
        print("called")
        print(data)
        newActivity.name=data
        acivityNameValue.text = data
      // implement your own implementation
       }
    @IBAction func selectDayRepeat(_ sender: UIButton) {
        if repSwitch.isOn{repSwitch.isOn = !repSwitch.isOn}
        print(String(sender.titleLabel!.text!))
        sender.isSelected = !sender.isSelected
    }
    @IBAction func checkRepeatEveryday(_ sender: Any) {
        for day in dayCollection{
            day.isSelected = repSwitch.isOn
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
        vc.delegate = self
        present(vc, animated: true)
    }
//    dismiss storyboard
    @IBAction func backtoDash(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

//    INPUT GOAL NAME CONTROLLER
}
class inputGoalController: UIViewController {
    var delegate: isAbleToReceiveData!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func viewWillDisappear() {
          delegate.pass(data: "someData") //call the func in the previous vc
      }
    @IBAction func closethisshit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func doneInput(_ sender: Any) {
//        TODO SAVE INPUT
        dismiss(animated: true, completion: nil)
        delegate.pass(data: nameTextField.text!)

    }
}

struct Activity {
    var name: String!
}

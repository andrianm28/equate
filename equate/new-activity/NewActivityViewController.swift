//
//  NewActivityViewController.swift
//  equate
//
//  Created by Alif Mahardhika on 08/04/21.
//

import UIKit
import Foundation
import CoreData
protocol isAbleToReceiveData {
    func pass(data: String)  //data: string is an example parameter
    func passIcon(icon: UIImage)
}

class NewActivityViewController: UIViewController, isAbleToReceiveData {
    
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var repSwitch: UISwitch!
    @IBOutlet var dayCollection: [UIButton]!
    @IBOutlet weak var activityCategoryValue: UILabel!
    @IBOutlet weak var activityIconValue: UIButton!
    @IBOutlet weak var activityDurationValue: UIDatePicker!
    @IBOutlet var clickableView: [UIView]!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    var newGoal = NewGoal(name: "")
    var delegate: isAbleToUpdatGoal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in clickableView{
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.cornerRadius = 10
        }
        setButton(butt: categoryButton!)
    }
    
    func pass(data: String) { //conforms to protocol
        newGoal.category = data
        activityCategoryValue.text = data
    }
    func passIcon(icon: UIImage) { //conforms to protocol
        newGoal.icon = icon
        activityIconValue.setImage(icon, for: .normal)
       }
    @IBAction func selectDayRepeat(_ sender: UIButton) {
        if repSwitch.isOn{repSwitch.isOn = !repSwitch.isOn}
        print(String(sender.titleLabel!.text!))
        sender.isSelected = !sender.isSelected
        print(newGoal.wed)
        for i in dayCollection{
            if i == sender{
                setRepeatValue(index: dayCollection.firstIndex(of: i)!)
                
            }
        }
    }
    
    @IBAction func selectCategory(_ sender: Any) {
//        present(inputGoalController(), animated: true)
//        let vc = storyboard?.instantiateViewController(identifier: "catNav") as! CategoryViewController
        let catStbrd: UIStoryboard = UIStoryboard(name: "Category", bundle: nil)
        let vc = catStbrd.instantiateViewController(identifier: "catView") as! CategoryViewController
//      present new storyboard
        vc.delegate = self
        present(vc, animated: true)
    }
    @IBAction func selectIcon(_ sender: Any) {
        let icStrbd: UIStoryboard = UIStoryboard(name: "Icon", bundle: nil)
        let vc = icStrbd.instantiateViewController(identifier: "iconView") as! IconViewController
//      present new storyboard
        vc.delegate = self
        present(vc, animated: true)
    }
    func setRepeatValue(index: Int){
        switch index {
        case 0:
            newGoal.sun = !newGoal.sun
        case 1:
            newGoal.mon = !newGoal.mon
        case 2:
            newGoal.tue = !newGoal.tue
        case 3:
            newGoal.wed = !newGoal.wed
        case 4:
            newGoal.thu = !newGoal.thu
        case 5:
            newGoal.fri = !newGoal.fri
        case 6:
            newGoal.sat = !newGoal.sat
        default:
            print(index)
        }
        
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
//        print(type(of:timePicker.date))
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.timeZone = TimeZone(abbreviation: "GMT+7:00")
//        TODO JAMNYA SALAH
        newGoal.time = timePicker.date//timeFormatter.date(from: timeFormatter.string(from: timePicker.date))
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: activityDurationValue.date)
        let hour = components.hour!
        let minute = components.minute!
        let totalDurationMinutes = (hour*60)+minute
        newGoal.durationInMinutes = totalDurationMinutes
        
        newGoal.name = nameTextField.text
        print(newGoal)
        dismiss(animated: true, completion: nil)
        delegate.pass(goal: newGoal)
    }
    
    
    @IBAction func checkRepeatEveryday(_ sender: Any) {
        for day in dayCollection{
            day.isSelected = repSwitch.isOn
            setRepeatValue(index: dayCollection.firstIndex(of: day)!)
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
    
    @IBAction func changeNameField(_ sender: Any) {
        nameTextField.text = ""
        nameTextField.textColor = UIColor.black
        
    }
    
    @IBAction func tapSetGoal(_ sender: Any) {
////        present(inputGoalController(), animated: true)
//        let vc = storyboard?.instantiateViewController(identifier: "inputGoal") as! inputGoalController
////      present new storyboard
//        vc.delegate = self
//        present(vc, animated: true)
    }
//    dismiss storyboard
    @IBAction func backtoDash(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    COREDATA STACK
    func getCoreDataContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    

}

func minutesToHoursAndMinutes (_ minutes : Int) -> (hours : Int , leftMinutes : Int) {
    return (minutes / 60, (minutes % 60))
}


public struct NewGoal {
    var name: String!
    var icon: UIImage!
    var category: String!
    var time: Date!
    var durationInMinutes: Int!
//    repetition
    var mon: Bool = false
    var tue: Bool = false
    var wed: Bool = false
    var thu: Bool = false
    var fri: Bool = false
    var sat: Bool = false
    var sun: Bool = false
}


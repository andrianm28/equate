//
//  UpdateGoalController.swift
//  equate
//
//  Created by Alif Mahardhika on 14/04/21.
//

import UIKit
import Foundation
import CoreData


class UpdateGoalController: UIViewController, isAbleToReceiveData {

    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var repSwitch: UISwitch!
    @IBOutlet weak var activityCategoryValue: UILabel!
    @IBOutlet var dayCollection: [UIButton]!
    @IBOutlet weak var activityIconValue: UIButton!
    @IBOutlet weak var activityDurationValue: UIDatePicker!
    @IBOutlet var clickableView: [UIView]!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    var newGoal = NewGoal(name: "")
    var delegate: isAbleToUpdatGoal!
    var delReload: listenToReloadCall!
    var targetGoal: Goal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in clickableView{
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.layer.cornerRadius = 10
        }
        setButton(butt: categoryButton!)
        if(targetGoal != nil){
            nameTextField.text = targetGoal.name
            activityCategoryValue.text = targetGoal.category
//            activityIconValue.setImage(targetGoal.icon, for: .normal)
            goalToStruct()
//            timePicker.date =
            activityDurationValue.countDownDuration = TimeInterval(Int(newGoal.durationInMinutes))
            setUpRepeatSelection()
        }
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
//        let calendar = Calendar.current
//        let date = calendar.date(byAdding: .hour, value: 7, to: timePicker.date)
//        print(date!)
//        newGoal.time = date//timeFormatter.date(from: timeFormatter.string(from: timePicker.date))
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: activityDurationValue.date)
        let hour = components.hour!
        let minute = components.minute!
        let totalDurationMinutes = (hour*60)+minute
        newGoal.durationInMinutes = totalDurationMinutes
        
        newGoal.name = nameTextField.text
        saveStructToGoal()
        dismiss(animated: true, completion: nil)
        delReload.passReload(reloadRequested: true)
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
//    dismiss storyboard
    @IBAction func backtoDash(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    COREDATA STACK
    func getCoreDataContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func goalToStruct(){
        newGoal.name = targetGoal.name
        newGoal.durationInMinutes = Int(targetGoal.duration)
        newGoal.category = targetGoal.category
//        newGoal.time = ta
        newGoal.sun = targetGoal.repeatEvery!.sun
        newGoal.mon = targetGoal.repeatEvery!.mon
        newGoal.tue = targetGoal.repeatEvery!.tue
        newGoal.wed = targetGoal.repeatEvery!.wed
        newGoal.thu = targetGoal.repeatEvery!.thu
        newGoal.fri = targetGoal.repeatEvery!.tue
        newGoal.sat = targetGoal.repeatEvery!.sat
    }
    
    func saveStructToGoal(){
        print("STRUCT:")
        print(newGoal)
        targetGoal.name = newGoal.name
        targetGoal.duration = Double(newGoal.durationInMinutes)
        targetGoal.category = newGoal.category
        targetGoal.repeatEvery!.sun = newGoal.sun
        targetGoal.repeatEvery!.mon = newGoal.mon
        targetGoal.repeatEvery!.tue = newGoal.tue
        targetGoal.repeatEvery!.wed = newGoal.wed
        targetGoal.repeatEvery!.thu = newGoal.thu
        targetGoal.repeatEvery!.fri = newGoal.fri
        targetGoal.repeatEvery!.sat = newGoal.sat
        
        print("GOAL:")
        print(targetGoal)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func setUpRepeatSelection(){
//        0 = sun, 6 = sat
        dayCollection[0].isSelected = newGoal.sun
        dayCollection[1].isSelected = newGoal.mon
        dayCollection[2].isSelected = newGoal.tue
        dayCollection[3].isSelected = newGoal.wed
        dayCollection[4].isSelected = newGoal.thu
        dayCollection[5].isSelected = newGoal.fri
        dayCollection[6].isSelected = newGoal.sat
        if(newGoal.sun && newGoal.mon && newGoal.tue && newGoal.wed && newGoal.thu && newGoal.fri && newGoal.sat){
            repSwitch.isOn = true
        }
    }
    

}

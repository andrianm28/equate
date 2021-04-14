//
//  ViewController.swift
//  equate
//
//  Created by M. Andrian Maulana on 31/03/21.
//

import UIKit
import CoreData
import Foundation

protocol isAbleToUpdatGoal {
    func pass(goal: NewGoal)
}
class DashboardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, isAbleToUpdatGoal{
    @IBOutlet weak var popupTimePicker: UIDatePicker!
    
    @IBOutlet weak var greyOut: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var todayGoalView: UITableView!
    @IBOutlet weak var summaryCollection: UICollectionView!
    @IBOutlet weak var addGoalButton: UIButton!
    var dash_title = ["Productivity","Leisure Time","Social","Rest and Sleep"]
    var dash_percent = [80,50,30,75]
    var dash_color = ["#A5B7FE","#F9CDAD","#BAB0F2","#B6F6C1"]
    var color_dict = ["prod":"#A5B7FE", "leis":"#F9CDAD", "soci":"#BAB0F2", "rest":"#B6F6C1"]
    var cat_array = ["prod","leis","soci","rest"]
    
    var selectedCell = 0
    
    var goal_list: [Goal] = []
    var catGoal_list: [CategoryGoal] = []
    var createdGoal: [NewGoal] = []
    var tempGoal:Goal!
    
    override func viewDidLoad() {
//        deleteAllData("Goal")
        getTodayGoals()
        calcCatPercent()
        getCatGoalData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        configureButton()
//        popupTimePicker.isHidden = true
    }
//    TRIGGER GOAL ARRAY APPEND
    func pass(goal: NewGoal){
        print("received")
        print(goal.name!)
        createdGoal.append(goal)
//        TODO update viewnya ni @devin
        structToGoal(structGoal: goal)
    }
    @IBAction func addGoalTapped(_ sender: Any) {
        let naStrbd: UIStoryboard = UIStoryboard(name: "NewActivity", bundle: nil)
        let vc = naStrbd.instantiateViewController(identifier: "na") as! NewActivityViewController
//      present new storyboard
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    func deleteAllData(_ entity:String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedObjectContext.delete(objectData)
            }
        } catch let error {
            print("Delete all data in \(entity) error :", error)
        }
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func createCategoryGoal(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let prodGoalEntity = NSEntityDescription.entity(forEntityName: "CategoryGoal", in: managedObjectContext)!
        
        let prodGoal = NSManagedObject(entity: prodGoalEntity, insertInto: managedObjectContext)
        prodGoal.setValue("prod", forKey: "category")
        prodGoal.setValue(0, forKey: "target_in_minutes")
        prodGoal.setValue(0, forKey: "progress_in_minutes")
        
        let leisGoalEntity = NSEntityDescription.entity(forEntityName: "CategoryGoal", in: managedObjectContext)!
        
        let leisGoal = NSManagedObject(entity: leisGoalEntity, insertInto: managedObjectContext)
        leisGoal.setValue("leis", forKey: "category")
        leisGoal.setValue(0, forKey: "target_in_minutes")
        leisGoal.setValue(0, forKey: "progress_in_minutes")
        
        let sociGoalEntity = NSEntityDescription.entity(forEntityName: "CategoryGoal", in: managedObjectContext)!
        
        let sociGoal = NSManagedObject(entity: sociGoalEntity, insertInto: managedObjectContext)
        sociGoal.setValue("soci", forKey: "category")
        sociGoal.setValue(0, forKey: "target_in_minutes")
        sociGoal.setValue(0, forKey: "progress_in_minutes")
        
        let restGoalEntity = NSEntityDescription.entity(forEntityName: "CategoryGoal", in: managedObjectContext)!
        
        let restGoal = NSManagedObject(entity: restGoalEntity, insertInto: managedObjectContext)
        restGoal.setValue("rest", forKey: "category")
        restGoal.setValue(0, forKey: "target_in_minutes")
        restGoal.setValue(0, forKey: "progress_in_minutes")
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func calcCatPercent(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedObjectContext = appDelegate.persistentContainer.viewContext

        let catGoalFetchRequest = NSFetchRequest<CategoryGoal>(entityName: "CategoryGoal")
        
        do {
            let catGoals = try managedObjectContext.fetch(catGoalFetchRequest)
            
            for catGoal in catGoals{
                catGoal.target_in_minutes = 0
                catGoal.progress_in_minutes = 0
                for goal in goal_list{
                    if (catGoal.category == goal.category){
                        catGoal.setValue(catGoal.progress_in_minutes + Int64(goal.progress), forKey: "progress_in_minutes")
                        catGoal.setValue(catGoal.target_in_minutes + Int64(goal.duration), forKey: "target_in_minutes")
                    }
                }
            }
            try managedObjectContext.save()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getCatGoalData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let goalFetchRequest = NSFetchRequest<CategoryGoal>(entityName: "CategoryGoal")
        
        do {
            for cat in cat_array{
                var fetchPredicate = NSPredicate(format: "category = %@", cat)
                goalFetchRequest.predicate = fetchPredicate
                let catGoal = try managedObjectContext.fetch(goalFetchRequest)
                catGoal_list.append(contentsOf: catGoal)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func createGoal(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext

        let repetitionEntity = NSEntityDescription.entity(forEntityName: "Repetition", in: managedObjectContext)!
        let repetition = NSManagedObject(entity: repetitionEntity, insertInto: managedObjectContext)
        repetition.setValue(true, forKey: "mon")
        repetition.setValue(true, forKey: "tue")
        repetition.setValue(true, forKey: "wed")
        repetition.setValue(true, forKey: "thu")
        repetition.setValue(true, forKey: "fri")
        repetition.setValue(true, forKey: "sat")
        repetition.setValue(true, forKey: "sun")

        let goalEntity = NSEntityDescription.entity(forEntityName: "Goal", in: managedObjectContext)!
        let goal = NSManagedObject(entity: goalEntity, insertInto: managedObjectContext)
        goal.setValue("prod", forKey: "category")
        goal.setValue(Double(60.0), forKey: "duration")
        goal.setValue(Double(45.0), forKey: "progress")
        goal.setValue("Grab coffee", forKey: "name")
        goal.setValue(repetition, forKey: "repeatEvery")

        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func structToGoal(structGoal: NewGoal){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let repetitionEntity = NSEntityDescription.entity(forEntityName: "Repetition", in: managedObjectContext)!
        let repetition = NSManagedObject(entity: repetitionEntity, insertInto: managedObjectContext)
//        todo repetition func
        repetition.setValue(structGoal.mon, forKey: "mon")
        repetition.setValue(structGoal.tue, forKey: "tue")
        repetition.setValue(structGoal.wed, forKey: "wed")
        repetition.setValue(structGoal.thu, forKey: "thu")
        repetition.setValue(structGoal.fri, forKey: "fri")
        repetition.setValue(structGoal.sat, forKey: "sat")
        repetition.setValue(structGoal.sun, forKey: "sun")
        
        let goalEntity = NSEntityDescription.entity(forEntityName: "Goal", in: managedObjectContext)!
        let goal = NSManagedObject(entity: goalEntity, insertInto: managedObjectContext)
        goal.setValue(structGoal.category, forKey: "category")
        goal.setValue(Double(structGoal.durationInMinutes), forKey: "duration")
        goal.setValue(Double(0.0), forKey: "progress")
        goal.setValue(structGoal.name, forKey: "name")
        goal.setValue(repetition, forKey: "repeatEvery")
        
        print("CALLED")
        print(goal.value(forKey: "name"))
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getTodayGoals(){
        let today = getDay()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
                
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let goalFetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        
        var fetchPredicate = NSPredicate()
        
        if(today == "Monday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.mon = %@", NSNumber(value: true))
        }
        else if(today == "Tuesday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.tue = %@", NSNumber(value: true))
        }
        else if (today == "Wednesday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.wed = %@", NSNumber(value: true))
        }
        else if (today == "Thursday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.thu = %@", NSNumber(value: true))
        }
        else if (today == "Friday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.fri = %@", NSNumber(value: true))
        }
        else if (today == "Saturday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.sat = %@", NSNumber(value: true))
        }
        else if (today == "Sunday"){
            fetchPredicate = NSPredicate(format: "repeatEvery.sun = %@", NSNumber(value: true))
        }
        
        goalFetchRequest.predicate = fetchPredicate
        
        do {
            let goals = try managedObjectContext.fetch(goalFetchRequest)
            
            goal_list = goals
            print("Goals Count \(goals.count)")
            
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func getDay() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    func configureButton(){
        addGoalButton.layer.cornerRadius = 10
        addGoalButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
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
        var percentage = 0
        if (catGoal_list[indexPath.row].progress_in_minutes != 0){
            print("masuk")
            print(catGoal_list[indexPath.row].category)
            print(catGoal_list[indexPath.row].progress_in_minutes)
            print(catGoal_list[indexPath.row].target_in_minutes)
            percentage = Int(catGoal_list[indexPath.row].progress_in_minutes*100) / Int(catGoal_list[indexPath.row].target_in_minutes)
        }
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
        return goal_list.count
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
        
        let goal = goal_list[indexPath.section]
        print("MARK")
        print(goal.name)
        
        cell.goalName.text = goal.name
        cell.layer.backgroundColor = hexStringToUIColor(hex: color_dict[goal.category]!).cgColor
        cell.goalTime.text = "\(Int(goal.progress)) out of \(Int(goal.duration)) minutes"
//
//        cell.goalName.text = goal_list[indexPath.row].name
//        cell.layer.backgroundColor = hexStringToUIColor(hex: color_dict[goal_list[indexPath.row].category]!).cgColor
//        cell.goalTime.text = "\(Int(goal_list[indexPath.row].progress)) out of \(Int(goal_list[indexPath.row].duration)) minutes"
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.selectedBackgroundView?.layer.cornerRadius = 10
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "Choose an option", preferredStyle: .actionSheet)
                
        // 2
        let editDurationAction = UIAlertAction(title: "Edit Duration Goal", style: .default) { (action:UIAlertAction!) in
            print("DURATION")
            self.tempGoal = self.goal_list[indexPath.section]
            self.greyOut.isHidden = false
        }
        let resetAction = UIAlertAction(title: "Reset Duration Goal", style: .default) { (action:UIAlertAction!) in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let goal = self.goal_list[indexPath.section]
            goal.progress = 0
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        let editAction = UIAlertAction(title: "Edit Goal Details", style: .default) { (action:UIAlertAction!) in
            print("EDIT")
        }


        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action:UIAlertAction!) in
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let goal = self.goal_list[indexPath.section]
            
            managedObjectContext.delete(goal)
            
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
            
        // 3
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            
        // 4
        optionMenu.addAction(editDurationAction)
        optionMenu.addAction(resetAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
            
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func cancelPicker(_ sender: Any) {
        greyOut.isHidden = true
    }
    
    @IBAction func updateProgress(_ sender: Any) {
        print("HERE")
        let components = Calendar.current.dateComponents([.hour, .minute], from: popupTimePicker.date)
        let hour = components.hour!
        let minute = components.minute!
        let totalDurationMinutes = (hour*60)+minute
//        newGoal.durationInMinutes = totalDurationMinutes
        tempGoal.progress = Double(totalDurationMinutes)
        greyOut.isHidden = true
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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

}

class ProgressView: UIViewController{
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelButton.backgroundColor = .clear
        cancelButton.layer.cornerRadius = 5
        doneButton.layer.cornerRadius = 5

        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.black.cgColor
    }
    @IBAction func saveButt(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let selectedRow = sender as? Int
        print("==================")
        print(selectedRow)
    }
}

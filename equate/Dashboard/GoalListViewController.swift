//
//  GoalListViewController.swift
//  equateApp 4.0
//
//  Created by Shofi Rafiiola on 12/04/21.
//

import UIKit

class GoalListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    let goalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let goalDateIndex = ["Sunday, 14th February 2021", "Monday, 15th February 2021", "Tuesday, 15th February 2021", "Wednesday, 15th February 2021"]
    
    
    var goals: [GoalList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goals = createArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func createArray() -> [GoalList] {
        
        var tempGoal: [GoalList] = []
        
        let goal1 = GoalList(image: #imageLiteral(resourceName: "Group 16"), title: "Karaoke", description: "lorem ipsum", time: "09.00 AM")
        let goal2 = GoalList(image: #imageLiteral(resourceName: "Group 9"), title: "Read a book", description: "lorem ipsum", time: "09.00 AM")
        let goal3 = GoalList(image: #imageLiteral(resourceName: "Group 7"), title: "Running", description: "lorem ipsum", time: "09.00 AM")
        let goal4 = GoalList(image: #imageLiteral(resourceName: "Group 20"), title: "Bowling", description: "lorem ipsum", time: "09.00 AM")
        let goal5 = GoalList(image: #imageLiteral(resourceName: "Group 28"), title: "Meeting", description: "lorem ipsum", time: "09.00 AM")
        let goal6 = GoalList(image: #imageLiteral(resourceName: "Group 11"), title: "Baking", description: "lorem ipsum", time: "09.00 AM")
        
        tempGoal.append(goal1)
        tempGoal.append(goal2)
        tempGoal.append(goal3)
        tempGoal.append(goal4)
        tempGoal.append(goal5)
        tempGoal.append(goal6)
        
        return tempGoal
        
    }
    


}

extension GoalListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let goal = goals[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalListTableViewCell") as! GoalListTableViewCell
        
        cell.setGoal(goal: goal)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return goalDateIndex[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return goalDateIndex.count
    }
    
    
    
}

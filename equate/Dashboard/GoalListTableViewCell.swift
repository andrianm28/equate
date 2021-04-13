//
//  GoalListTableViewCell.swift
//  equateApp 4.0
//
//  Created by Shofi Rafiiola on 12/04/21.
//

import UIKit

class GoalListTableViewCell: UITableViewCell {

//    @IBOutlet weak var goalImageView: UIImageView!
//    @IBOutlet weak var goalTitleLabel: UILabel!
//    @IBOutlet weak var goalDescLabel: UILabel!
//    @IBOutlet weak var goalTimeLabel: UILabel!
    
    @IBOutlet weak var goalImageView: UIImageView!
    @IBOutlet weak var goalTitleLabel: UILabel!
    @IBOutlet weak var goalDescLabel: UILabel!
    @IBOutlet weak var goalTimeLabel: UILabel!
    
    func setGoal(goal: GoalList){
        
        goalImageView.image = goal.image
        goalTitleLabel.text = goal.title
        goalDescLabel.text = goal.description
        goalTimeLabel.text = goal.time

        
    }

}

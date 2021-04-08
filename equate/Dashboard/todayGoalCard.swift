//
//  todayGoalCard.swift
//  equate
//
//  Created by Devin Winardi on 08/04/21.
//

import UIKit

class todayGoalCard: UITableViewCell {

    @IBOutlet weak var goalName: UILabel!
    @IBOutlet weak var goalTime: UILabel!
    @IBOutlet weak var goalIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 1)
        self.layer.shadowOpacity = 0.5
        
        goalIcon.layer.cornerRadius = 10
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 10
            frame.size.width -= 2 * 10
            super.frame = frame
        }
    }

}

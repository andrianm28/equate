//
//  Goal+CoreDataProperties.swift
//  equate
//
//  Created by Alif Mahardhika on 12/04/21.
//
//

import Foundation
import CoreData

    
extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var category: String
    @NSManaged public var duration: Double
    @NSManaged public var progress: Double
    @NSManaged public var name: String
    @NSManaged public var repeatEvery: Repetition?

}

extension Goal : Identifiable {

}

//
//  Dashboard+CoreDataProperties.swift
//  equate
//
//  Created by Alif Mahardhika on 12/04/21.
//
//

import Foundation
import CoreData


extension Dashboard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dashboard> {
        return NSFetchRequest<Dashboard>(entityName: "Dashboard")
    }

    @NSManaged public var day: String?
    @NSManaged public var date: Date?
    @NSManaged public var hasGoals: NSSet?

}

// MARK: Generated accessors for hasGoals
extension Dashboard {

    @objc(addHasGoalsObject:)
    @NSManaged public func addToHasGoals(_ value: CategoryGoal)

    @objc(removeHasGoalsObject:)
    @NSManaged public func removeFromHasGoals(_ value: CategoryGoal)

    @objc(addHasGoals:)
    @NSManaged public func addToHasGoals(_ values: NSSet)

    @objc(removeHasGoals:)
    @NSManaged public func removeFromHasGoals(_ values: NSSet)

}

extension Dashboard : Identifiable {

}

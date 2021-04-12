//
//  CategoryGoal+CoreDataProperties.swift
//  equate
//
//  Created by Alif Mahardhika on 12/04/21.
//
//

import Foundation
import CoreData


extension CategoryGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryGoal> {
        return NSFetchRequest<CategoryGoal>(entityName: "CategoryGoal")
    }

    @NSManaged public var category: String?
    @NSManaged public var target_in_minutes: Int64
    @NSManaged public var progress_in_minutes: Int64

}

extension CategoryGoal : Identifiable {

}

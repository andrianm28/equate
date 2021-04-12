//
//  Repetition+CoreDataProperties.swift
//  equate
//
//  Created by Alif Mahardhika on 12/04/21.
//
//

import Foundation
import CoreData


extension Repetition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repetition> {
        return NSFetchRequest<Repetition>(entityName: "Repetition")
    }

    @NSManaged public var mon: Bool
    @NSManaged public var tue: Bool
    @NSManaged public var wed: Bool
    @NSManaged public var thu: Bool
    @NSManaged public var fri: Bool
    @NSManaged public var sat: Bool
    @NSManaged public var sun: Bool

}

extension Repetition : Identifiable {

}

//
//  Workoutentity.swift
//  GainsRoutine
//
//  Created by Arya Somu on 3/18/24.
//

import Foundation
import CoreData

@objc(WorkoutEntity)
public class WorkoutEntity: NSManagedObject {
    @NSManaged public var date: Date?
    @NSManaged public var exercise: String?
    @NSManaged public var duration: Int16
}

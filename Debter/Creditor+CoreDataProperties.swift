//
//  Creditor+CoreDataProperties.swift
//  Debter
//
//  Created by Samu Tuominen on 11.6.2015.
//  Copyright © 2015 Samu Tuominen. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Creditor {

    @NSManaged var name: String
    @NSManaged var events: NSSet
    var amount: Double {
        let allEvents = self.events.allObjects as! [Event]
        var sum = 0.0
        for i in allEvents {
            sum += i.sum.doubleValue
        }
        return sum
    }
}

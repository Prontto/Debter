//
//  Velka+CoreDataProperties.swift
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

extension Velka {

    @NSManaged var pvm: NSDate
    @NSManaged var summa: NSNumber
    @NSManaged var kuvaus: String
    @NSManaged var velkoja: Velkoja

}
